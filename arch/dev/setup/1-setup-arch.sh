#!/usr/bin/env bash

# This script installs the packages I like to have in Arch.
mkdir ~/builds; cd ~/builds

# Cloning/Making AUR
sudo pacman -S git base-devel
sudo git clone https://aur.archlinux.org/yay.git
cd yay
sudo makepkg -si

sudo pacman -S --noconfirm --needed pigz pbzip2  # For AUR config(faster go brrr)

# Firmware: remove warning messages for x230 laptop Arch build 
yay -S --noconfirm --needed mkinitcpio

sudo pacman -s --noconfirm --needed power-profiles-daemon
sudo pacman -s --noconfirm --needed imv
sudo pacman -S --noconfirm --needed ghostty
sudo pacman -S --noconfirm --needed less man man-db man-pages glibc
sudo pacman -S --noconfirm --needed nano vim cups cups-pdf
sudo pacman -S --noconfirm --needed brightnessctl playerctl timedatectl
sudo pacman -S --noconfirm --needed wayland ttf-jetbrains-mono-nerd otf-font-awesome ttf-nerd-fonts-symbols
sudo pacman -S --noconfirm --needed pkgstats
sudo pacman -S --noconfirm --needed cups

yay -S --noconfirm --needed zen-browser-bin
echo 'use pkgstats to send list of packages installed to distro devs'

# NOT USED, only here for reference if ever needed for X230 Lenovo Laptop
# yay -S --noconfirm --needed linux-firmware-qlogic 
# yay -S --noconfirm --needed ast-firmware 
# yay -S --noconfirm --needed aic94xx-firmware 
# yay -S --noconfirm --needed wd719x-firmware

# sudo pacman -S --noconfirm --needed dosfstools hardparm mesa-utils
# sudo pacman -s --noconfirm --needed thermald
# sudo pacman -S --noconfirm --needed ntfs-3g
