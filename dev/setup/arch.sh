#!/usr/bin/env bash

# Installs the packages I like to have in Arch.
# I made this so I don't need to find and manually install each.

mkdir ~/builds; cd ~/builds

# Downloading/Installing AUR
sudo pacman -S git base-devel
sudo git clone https://aur.archlinux.org/yay.git
cd yay
sudo makepkg -si

sudo yay --repo -S pigz pbzip2  # For AUR config(faster go brrr)
sudo yay --repo -S less man mandb man-pages glibc
sudo yay --repo -S nano vim
sudo yay --repo -S brightnessctl playerctl
sudo yay --repo -S chromium

