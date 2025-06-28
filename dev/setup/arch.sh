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

sudo yay --repo -S dosfstools hardparm mesa-utils
sudo yay --repo -S ntfs-3g
sudo yay --repo -S less man mandb man-pages glibc
sudo yay --repo -S nano vim cups cups-pdf
sudo yay --repo -S brightnessctl playerctl
sudo yay --repo -S wayland
sudo yay --repo -S chromium brave
sudo yay --repo -S pkgstats
echo 'use pkgstats to send list of packages installed to distro devs'
