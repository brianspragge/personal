#!/usr/bin/env bash

# Sym links files from ~/personal/dev/user/ to ~/
# I made this to keep my ~/ neat.  I didn't like .git in there.


link_file() {
    local src="$1"
    local dest="$2"

    if [[ -e "$src" ]]; then
        ln -sf "$src" "$dest"
        if [[ -L "$dest" ]]; then
            echo "Linked: $dest → $src"
        else
            echo "Failed to link: $dest"
        fi
    else
        echo "Source missing: $src"
    fi
}

link_file "$HOME/personal/dev/user/.bashrc"           "$HOME/.bashrc"
link_file "$HOME/personal/dev/user/.clang-format"     "$HOME/.clang-format"
link_file "$HOME/personal/dev/user/gpg_crd_cmds.txt" "$HOME/gpg_crd_cmds.txt"
link_file "$HOME/personal/dev/user/gpgcli.sh"       "$HOME/gpgcli.sh"
link_file "$HOME/personal/dev/user/.inputrc"          "$HOME/.inputrc"
link_file "$HOME/personal/dev/user/.vimrc"            "$HOME/.vimrc"
link_file "$HOME/personal/dev/user/fastfetch/config.jsonc"   "$HOME/.config/fastfetch/config.jsonc"
link_file "$HOME/personal/dev/user/.drirc"            "$HOME/.drirc"
link_file "$HOME/personal/dev/user/get-color.sh"            "$HOME/get-color.sh"
link_file "$HOME/personal/dev/user/ghostty/config"   "$HOME/.config/ghostty/config"
link_file "$HOME/personal/dev/user/dunst/dunstrc"   "$HOME/.config/dunst/dunstrc"
link_file "$HOME/personal/dev/user/waybar/config.jsonc"   "$HOME/.config/waybar/config.jsonc"
link_file "$HOME/personal/dev/user/waybar/style.css"   "$HOME/.config/waybar/style.css"
link_file "$HOME/personal/dev/user/hypr/hyprland.conf"   "$HOME/.config/hypr/hyprland.conf"
link_file "$HOME/personal/dev/user/hypr/hyprlock.conf"   "$HOME/.config/hypr/hyprlock.conf"
link_file "$HOME/personal/dev/user/hypr/hyprpaper.conf"   "$HOME/.config/hypr/hyprpaper.conf"
