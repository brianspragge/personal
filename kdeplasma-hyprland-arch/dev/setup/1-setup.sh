#!/usr/bin/env bash

# This script installs the packages I like to have in Arch.

# Cloning/Making AUR
mkdir ~/builds; cd ~/builds
git clone https://aur.archlinux.org/yay-bin.git
cd yay
makepkg -si

# Packages being installed
sudo pacman -S --noconfirm --needed glibc imv man man-db man-pages pkgstats
yay -S --noconfirm --needed zen-browser-bin
echo
echo 'use pkgstats to send list of packages installed to distro devs'
