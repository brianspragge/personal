#!/usr/bin/env bash

# List of all packages mentioned in your setup script
packages=(
  pigz pbzip2 mkinitcpio linux-firmware-qlogic ast-firmware
  aic94xx-firmware wd719x-firmware dosfstools hardparm mesa-utils
  thermald power-profiles-daemon imv ntfs-3g ghostty less man mandb
  man-pages glibc nano vim cups cups-pdf brightnessctl playerctl
  timedatectl wayland ttf-jetbrains-mono-nerd ttf-font-awesome
  ttf-nerd-fonts-symbols pkgstats zen-browser-bin
)

echo "🔍 Checking installed packages..."
echo

for pkg in "${packages[@]}"; do
  if pacman -Qi "$pkg" &>/dev/null; then
    echo "✅ $pkg is installed"
  else
    echo "❌ $pkg is NOT installed"
  fi
done

