#!/usr/bin/env bash
# ------------------------------------------------------------
# Copy personal config files from the repo into $HOME.
# For each file: shows what differs (if the destination exists)
# and asks whether to copy it. No symlinks are created.
# ------------------------------------------------------------
set -uo pipefail

BASE="$HOME/Repos/personal/omarchy/dev/user"

# Returns 0 if src and dst are in sync, 1 otherwise. Prints what differs.
needs_copy() {
    local src="$1" dst="$2"

    if [[ ! -e "$dst" ]]; then
        echo "    (not installed)"
        return 1
    fi

    if [[ -d "$src" && -d "$dst" ]]; then
        if diff -rq "$src" "$dst" >/dev/null 2>&1; then
            return 0
        fi
        echo "    differences:"
        diff -rq "$src" "$dst" 2>&1 | sed 's/^/      /' | head -30 || true
        return 1
    fi

    if diff -q "$src" "$dst" >/dev/null 2>&1; then
        return 0
    fi
    echo "    diff (repo -> installed):"
    diff -u "$dst" "$src" 2>&1 | sed 's/^/      /' | head -60 || true
    return 1
}

copy_one() {
    local src="$1" dst="$2" desc="$3"

    if [[ ! -e "$src" ]]; then
        echo "WARN: source missing, skipping: $src"
        return 0
    fi

    echo "--- $desc"
    if needs_copy "$src" "$dst"; then
        echo "    already in sync, skipping."
        return 0
    fi

    local ans
    read -r -p "    Copy $desc? [Y/n] " ans
    case "${ans,,}" in
        n|no) echo "    skipped."; return 0 ;;
        *) ;;
    esac

    mkdir -p "$(dirname "$dst")"
    if [[ -d "$src" ]]; then
        if [[ -d "$dst" ]]; then
            cp -r -- "$src/." "$dst/"
        else
            cp -r -- "$src" "$dst"
        fi
    else
        cp -f -- "$src" "$dst"
        if [[ -x "$src" ]]; then
            chmod +x -- "$dst"
        fi
    fi
    echo "    copied -> $dst"
}

# dot-files
copy_one "$BASE/.bashrc"  "$HOME/.bashrc"  ".bashrc"
copy_one "$BASE/.inputrc" "$HOME/.inputrc" ".inputrc"
copy_one "$BASE/.vimrc"   "$HOME/.vimrc"   ".vimrc"

# hypr
for f in autostart bindings input looknfeel monitors; do
    copy_one "$BASE/.config/hypr/$f.lua" "$HOME/.config/hypr/$f.lua" "hypr/$f.lua"
done

# scripts in .local/bin
copy_one "$BASE/.local/bin/getcolor"  "$HOME/.local/bin/getcolor"  "getcolor"
copy_one "$BASE/.local/bin/gpgcli"     "$HOME/.local/bin/gpgcli"     "gpgcli"
copy_one "$BASE/.local/bin/gpg_ref.txt" "$HOME/.local/bin/gpg_ref.txt" "gpg_ref.txt"

# vim thesaurus
copy_one "$BASE/.vim/thesaurus" "$HOME/.vim/thesaurus" ".vim/thesaurus"

# personal .desktop launchers
copy_one "$BASE/.local/share/applications/Casio Calculator.desktop" \
         "$HOME/.local/share/applications/Casio Calculator.desktop" \
         "Casio Calculator.desktop"
copy_one "$BASE/.local/share/applications/Fred.desktop" \
         "$HOME/.local/share/applications/Fred.desktop" \
         "Fred.desktop"
copy_one "$BASE/.local/share/applications/gf2.desktop" \
         "$HOME/.local/share/applications/gf2.desktop" \
         "gf2.desktop"
copy_one "$BASE/.local/share/applications/Wayland-Docs.desktop" \
         "$HOME/.local/share/applications/Wayland-Docs.desktop" \
         "Wayland-Docs.desktop"

# icons for the launchers above
copy_one "$BASE/.local/share/applications/icons/Casio Calculator.png" \
         "$HOME/.local/share/applications/icons/Casio Calculator.png" \
         "icons/Casio Calculator.png"
copy_one "$BASE/.local/share/applications/icons/fred.svg" \
         "$HOME/.local/share/applications/icons/fred.svg" \
         "icons/fred.svg"
copy_one "$BASE/.local/share/applications/icons/gf2.png" \
         "$HOME/.local/share/applications/icons/gf2.png" \
         "icons/gf2.png"
copy_one "$BASE/.local/share/applications/icons/wayland.png" \
         "$HOME/.local/share/applications/icons/wayland.png" \
         "icons/wayland.png"

# ------------------------------------------------------------------
# vim ctags (tags/ is not tracked; regenerate on demand)
# ------------------------------------------------------------------
if command -v ctags >/dev/null 2>&1; then
    echo "--- vim ctags"
    read -r -p "    Regenerate ~/.vim/tags (C++ and Python stdlib)? [Y/n] " ans
    case "${ans,,}" in
        n|no)
            echo "    skipped."
            ;;
        *)
            mkdir -p "$HOME/.vim/tags"
            echo "    building C++ tags from /usr/include (this takes a while)..."
            ctags -R --languages=C,C++ --fields=+iaS --extras=+q \
                -f "$HOME/.vim/tags/cpp.tags" /usr/include 2>/dev/null || true
            PYSTDLIB=$(python -c "import sysconfig; print(sysconfig.get_path('stdlib'))" 2>/dev/null)
            if [[ -n "$PYSTDLIB" ]]; then
                echo "    building Python stdlib tags..."
                ctags -R --languages=Python --fields=+iaS --extras=+q \
                    -f "$HOME/.vim/tags/python_stdlib.tags" "$PYSTDLIB" 2>/dev/null || true
            fi
            echo "    tags written to ~/.vim/tags/"
            ;;
    esac
fi

# ------------------------------------------------------------------
# bash tab-completion: show hidden files
# ------------------------------------------------------------------
INPUTC="${OMARCHY_PATH:-/usr/share/omarchy}/default/bash/inputrc"
if [[ -f "$INPUTC" ]] && grep -q "set match-hidden-files off" "$INPUTC"; then
    echo "--- bash tab-completion currently hides dotfiles"
    read -r -p "    Show hidden files in tab-completion? [Y/n] " ans
    case "${ans,,}" in
        n|no)
            echo "    skipped."
            ;;
        *)
            sed -i 's/^set match-hidden-files off/set match-hidden-files on/' "$INPUTC"
            echo "    set -> match-hidden-files on"
            ;;
    esac
else
    echo "--- bash inputrc: match-hidden-files already on (or file missing), skipping."
fi

echo "Done."
