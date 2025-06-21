#!/usr/bin/env bash

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
        echo "⚠️Source missing: $src"
    fi
}

link_file "$HOME/.rc/.bashrc"           "$HOME/.bashrc"
link_file "$HOME/.rc/.clang-format"     "$HOME/.clang-format"
link_file "$HOME/.rc/.gpg_crd_cmds.txt" "$HOME/.gpg_crd_cmds.txt"
link_file "$HOME/.rc/.gpg_crd.sh"       "$HOME/.gpg_crd.sh"
link_file "$HOME/.rc/.inputrc"          "$HOME/.inputrc"
link_file "$HOME/.rc/.vimrc"            "$HOME/.vimrc"

