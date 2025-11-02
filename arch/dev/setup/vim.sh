#!/usr/bin/env bash

# Downloads necessary packages for Vim's LSP servers.
# I made this to automate the process of setting up my Vim.


printf "%s\n" "Searching for .env..."
if [[ ! -f ~/.env/bin/activate ]]; then
    cat <<EOF
Error: search for .env: FAILED
Create an .env in your ~/ (home/user) folder! EX:
    python -m venv .env

Premature EXITING...
EOF
    exit 1
fi

echo 'Activating .env...'
source ~/.env/bin/activate
if [[ -z "$VIRTUAL_ENV" ]]; then
  cat <<EOF
Activation of .env: FAILED.

Premature EXITING...
EOF
  exit 1
else
  echo 'Activation of .env: SUCCESS.'
fi

echo 'Intalling Plugged, a vim plugin handler...'
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo 'Installing Jedi LSP server for Vim...'
pip install plugged jedi-language-server

# This should really be in another file...
echo 'Resetting pacman GPG keyring...'
sudo rm -rf /etc/pacman.d/gnupg
sudo pacman-key --init
sudo pacman-key --populate archlinux
sudo pacman-key --refresh-keys --keyserver hkps://keys.openpgp.org

echo 'Installing packages for Bash LSP server for Vim...'
sudo pacman -S --needed --noconfirm clang ctags base-devel nodejs npm
sudo npm install -g bash-language-server

cat <<EOF
Setup complete!'
Well, almost.  You still need to <:PlugInstall> in vim.

EOF
read -srn1 -p 'Press any key to continue...'
