#!/usr/bin/env bash

# This script installs the packages I like to have in Arch.
mkdir ~/builds; cd ~/builds

# Cloning/Making AUR
sudo pacman -S git base-devel
sudo git clone https://aur.archlinux.org/yay.git
cd yay
sudo makepkg -si

sudo yay --repo -S pigz pbzip2  # For AUR config(faster go brrr)

# Firmware: remove warning messages for x230 laptop Arch build 
sudo yay --aur mkinitcpio
sudo yay --aur linux-firmware-qlogic 
sudo yay --aur ast-firmware 
sudo yay --aur aic94xx-firmware 
sudo yay --aur wd719x-firmware

sudo yay --repo -S less man mandb man-pages glibc
sudo yay --repo -S nano vim
sudo yay --repo -S brightnessctl playerctl
sudo yay --repo -S chromium
sudo yay --repo -S pkgstats
