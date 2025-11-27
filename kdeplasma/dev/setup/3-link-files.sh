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
BASE="$HOME/personal/kdeplasma-hyprland-arch/dev/user"

# ------------------------------------------------------------------
# All the files
# ------------------------------------------------------------------
# config files
link_file "$BASE/.config/dunst/dunstrc"          "$HOME/.config/dunst/dunstrc"
link_file "$BASE/.config/fastfetch/config.jsonc" "$HOME/.config/fastfetch/config.jsonc"
# hypr
link_file "$BASE/.config/hypr/wallpaper/firered.png" "$HOME/.config/hypr/wallpaper/firered.png"
link_file "$BASE/.config/hypr/hyprland.conf"         "$HOME/.config/hypr/hyprland.conf"
link_file "$BASE/.config/hypr/hyprlandPersonal.conf" "$HOME/.config/hypr/hyprlandPersonal.conf"
link_file "$BASE/.config/hypr/hyprlock.conf"         "$HOME/.config/hypr/hyprlock.conf"
link_file "$BASE/.config/hypr/hyprpaper.conf"        "$HOME/.config/hypr/hyprpaper.conf"
# waybar
link_file "$BASE/.config/waybar/config.jsonc" "$HOME/.config/waybar/config.jsonc"
link_file "$BASE/.config/waybar/style.css"    "$HOME/.config/waybar/style.css"

# plain files in .local/bin
link_file "$BASE/.local/bin/get-color"        "$HOME/.local/bin/get-color"
link_file "$BASE/.local/bin/gpgcli"           "$HOME/.local/bin/gpgcli"

# dot-files
link_file "$BASE/.bashrc"       "$HOME/.bashrc"
link_file "$BASE/.inputrc"      "$HOME/.inputrc"
link_file "$BASE/.vimrc"        "$HOME/.vimrc"

# ------------------------------------------------------------
# Finish
# ------------------------------------------------------------
echo
echo "Finished"

