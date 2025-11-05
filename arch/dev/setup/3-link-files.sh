#!/usr/bin/env bash
# ------------------------------------------------------------
# Symlink user config files from the repo into $HOME
# ------------------------------------------------------------
set -euo pipefail   # safer bash

# ------------------------------------------------------------------
# Helper: create parent dirs, back up old files, create symlink
# ------------------------------------------------------------------
link_file() {
    local src="$1"   # full path in the repo
    local dst="$2"   # full path in $HOME

    # 1. Make sure the source really exists
    if [[ ! -e "$src" ]]; then
        echo "WARNING: Source missing – skipping: $src"
        return 0                # continue with the rest of the script
    fi

    # 2. Ensure parent directory exists
    mkdir -p "$(dirname "$dst")"

    # 3. Back up an existing real file (not a symlink)
    if [[ -e "$dst" && ! -L "$dst" ]]; then
        local bak="${dst}.bak.$(date +%Y%m%d%H%M%S)"
        echo "Backing up: $dst → $bak"
        mv -- "$dst" "$bak"
    fi

    # 4. Create / update the symlink
    if ln -sf -- "$src" "$dst"; then
        # Verify it points to the right place
        if [[ "$(readlink -f "$dst")" == "$(realpath "$src")" ]]; then
            echo "Linked: $dst → $src"
        else
            echo "ERROR: symlink created but points elsewhere!"
            return 1
        fi
    else
        echo "ERROR: failed to create symlink $dst"
        return 1
    fi
}

# ------------------------------------------------------------------
# Base directory
# ------------------------------------------------------------------
BASE="$HOME/personal/arch/dev/user"

# ------------------------------------------------------------------
# All the files
# ------------------------------------------------------------------
# config files
link_file "$BASE/.config/dunst/dunstrc"                     "$HOME/.config/dunst/dunstrc"
link_file "$BASE/.config/fastfetch/config.jsonc"           "$HOME/.config/fastfetch/config.jsonc"
link_file "$BASE/.config/ghostty/config"                   "$HOME/.config/ghostty/config"
# hypr
link_file "$BASE/.config/hypr/wallpaper/firered.png"       "$HOME/.config/hypr/wallpaper/firered.png"
link_file "$BASE/.config/hypr/hyprland.conf"               "$HOME/.config/hypr/hyprland.conf"
link_file "$BASE/.config/hypr/hyprlandPersonal.conf"       "$HOME/.config/hypr/hyprlandPersonal.conf"
link_file "$BASE/.config/hypr/hyprlock.conf"               "$HOME/.config/hypr/hyprlock.conf"
link_file "$BASE/.config/hypr/hyprpaper.conf"              "$HOME/.config/hypr/hyprpaper.conf"
# waybar
link_file "$BASE/.config/waybar/config.jsonc"              "$HOME/.config/waybar/config.jsonc"
link_file "$BASE/.config/waybar/style.css"                 "$HOME/.config/waybar/style.css"

# dot-files
link_file "$BASE/.bashrc"          "$HOME/.bashrc"
link_file "$BASE/.clang-format"    "$HOME/.clang-format"
link_file "$BASE/.drirc"           "$HOME/.drirc"
link_file "$BASE/.inputrc"         "$HOME/.inputrc"
link_file "$BASE/.vimrc"           "$HOME/.vimrc"

# plain files in .local/bin
link_file "$BASE/.local/bin/get-color"     "$HOME/.local/bin/get-color"
link_file "$BASE/.local/bin/gpg_crd_cmds.txt" "$HOME/.local/bin/gpg_crd_cmds.txt"
link_file "$BASE/.local/bin/gpgcli"        "$HOME/.local/bin/gpgcli"

# ------------------------------------------------------------------
# Plymouth theme – charmander
# ------------------------------------------------------------------
link_file "$BASE/plymouth/charmander/bullet.png"            "/usr/share/plymouth/themes/charmander/bullet.png"
link_file "$BASE/plymouth/charmander/capslock.png"          "/usr/share/plymouth/themes/charmander/capslock.png"
link_file "$BASE/plymouth/charmander/charmander.plymouth"   "/usr/share/plymouth/themes/charmander/charmander.plymouth"
link_file "$BASE/plymouth/charmander/entry.png"             "/usr/share/plymouth/themes/charmander/entry.png"
link_file "$BASE/plymouth/charmander/keyboard.png"          "/usr/share/plymouth/themes/charmander/keyboard.png"
link_file "$BASE/plymouth/charmander/keymap-render.png"     "/usr/share/plymouth/themes/charmander/keymap-render.png"
link_file "$BASE/plymouth/charmander/lock.png"              "/usr/share/plymouth/themes/charmander/lock.png"
link_file "$BASE/plymouth/charmander/throbber-0001.png"     "/usr/share/plymouth/themes/charmander/throbber-0001.png"
link_file "$BASE/plymouth/charmander/throbber-0002.png"     "/usr/share/plymouth/themes/charmander/throbber-0002.png"
link_file "$BASE/plymouth/charmander/throbber-0003.png"     "/usr/share/plymouth/themes/charmander/throbber-0003.png"
link_file "$BASE/plymouth/charmander/throbber-0004.png"     "/usr/share/plymouth/themes/charmander/throbber-0004.png"
link_file "$BASE/plymouth/charmander/throbber-0005.png"     "/usr/share/plymouth/themes/charmander/throbber-0005.png"
link_file "$BASE/plymouth/charmander/throbber-0006.png"     "/usr/share/plymouth/themes/charmander/throbber-0006.png"
link_file "$BASE/plymouth/charmander/throbber-0007.png"     "/usr/share/plymouth/themes/charmander/throbber-0007.png"
link_file "$BASE/plymouth/charmander/throbber-0008.png"     "/usr/share/plymouth/themes/charmander/throbber-0008.png"
link_file "$BASE/plymouth/charmander/throbber-0009.png"     "/usr/share/plymouth/themes/charmander/throbber-0009.png"
link_file "$BASE/plymouth/charmander/throbber-0010.png"     "/usr/share/plymouth/themes/charmander/throbber-0010.png"
link_file "$BASE/plymouth/charmander/throbber-0011.png"     "/usr/share/plymouth/themes/charmander/throbber-0011.png"
link_file "$BASE/plymouth/charmander/throbber-0012.png"     "/usr/share/plymouth/themes/charmander/throbber-0012.png"
link_file "$BASE/plymouth/charmander/throbber-0013.png"     "/usr/share/plymouth/themes/charmander/throbber-0013.png"
link_file "$BASE/plymouth/charmander/throbber-0014.png"     "/usr/share/plymouth/themes/charmander/throbber-0014.png"
link_file "$BASE/plymouth/charmander/throbber-0015.png"     "/usr/share/plymouth/themes/charmander/throbber-0015.png"
link_file "$BASE/plymouth/charmander/throbber-0016.png"     "/usr/share/plymouth/themes/charmander/throbber-0016.png"
link_file "$BASE/plymouth/charmander/throbber-0017.png"     "/usr/share/plymouth/themes/charmander/throbber-0017.png"
link_file "$BASE/plymouth/charmander/throbber-0018.png"     "/usr/share/plymouth/themes/charmander/throbber-0018.png"
link_file "$BASE/plymouth/charmander/throbber-0019.png"     "/usr/share/plymouth/themes/charmander/throbber-0019.png"
link_file "$BASE/plymouth/charmander/throbber-0020.png"     "/usr/share/plymouth/themes/charmander/throbber-0020.png"
link_file "$BASE/plymouth/charmander/throbber-0021.png"     "/usr/share/plymouth/themes/charmander/throbber-0021.png"
link_file "$BASE/plymouth/charmander/throbber-0022.png"     "/usr/share/plymouth/themes/charmander/throbber-0022.png"
link_file "$BASE/plymouth/charmander/throbber-0023.png"     "/usr/share/plymouth/themes/charmander/throbber-0023.png"
link_file "$BASE/plymouth/charmander/throbber-0024.png"     "/usr/share/plymouth/themes/charmander/throbber-0024.png"
link_file "$BASE/plymouth/charmander/throbber-0025.png"     "/usr/share/plymouth/themes/charmander/throbber-0025.png"
link_file "$BASE/plymouth/charmander/watermark.png"         "/usr/share/plymouth/themes/charmander/watermark.png"

# ------------------------------------------------------------------
# Activate Plymouth theme (requires sudo)
# ------------------------------------------------------------------
echo "Setting Plymouth theme to charmander..."
sudo plymouth-set-default-theme charmander
sudo mkinitcpio -P
echo "Theme activated! Reboot to see it."

# ------------------------------------------------------------
# Finish
# ------------------------------------------------------------
echo "All symlinks processed."

