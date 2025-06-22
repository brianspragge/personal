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
link_file "$HOME/personal/dev/user/gpg_crd.sh"       "$HOME/gpg_crd.sh"
link_file "$HOME/personal/dev/user/.inputrc"          "$HOME/.inputrc"
link_file "$HOME/personal/dev/user/.vimrc"            "$HOME/.vimrc"

