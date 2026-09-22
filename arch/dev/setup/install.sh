#!/usr/bin/env bash
set -euo pipefail

# Install the Arch profile, configure the desktop, and install user tooling.
# Run as the normal user from any directory.
if [[ "$EUID" -eq 0 ]]; then
    printf '%s\n' 'Run this script as your normal user; it uses sudo when needed.' >&2
    exit 1
fi
if ! command -v sudo >/dev/null 2>&1; then
    printf '%s\n' 'sudo is required. Install it and grant this user sudo access first.' >&2
    exit 1
fi
sudo -v

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
BASE="$(cd -- "$SCRIPT_DIR/../user" && pwd)"

echo 'Installing packages...'
sudo pacman -Syu --noconfirm --needed \
    base-devel sudo git curl linux-firmware iw \
    pigz pbzip2 \
    power-profiles-daemon networkmanager network-manager-applet iwd bluez bluez-utils blueman imv ghostty \
    less man man-db man-pages glibc nano vim tmux mpd \
    cups cups-pdf brightnessctl playerctl \
    wayland hyprland waybar dunst hyprpaper hyprlock alacritty sddm \
    xdg-desktop-portal-hyprland xdg-desktop-portal-gtk qt5-wayland qt6-wayland \
    wofi dolphin gimp grim slurp wl-clipboard imagemagick libnotify pavucontrol dmenu xdg-utils \
    polkit-kde-agent \
    eza btop cowsay nvm rustup bash-completion \
    pipewire pipewire-audio pipewire-pulse wireplumber \
    ttf-jetbrains-mono-nerd otf-font-awesome ttf-nerd-fonts-symbols \
    fastfetch pkgstats \
    python python-pip clang ctags nodejs npm bash-language-server gnupg

if ! rustup toolchain list 2>/dev/null | grep -q '^stable'; then
    rustup default stable
fi

install_yay() {
    if command -v yay >/dev/null 2>&1; then
        return
    fi

    local build_dir
    build_dir="$(mktemp -d)"
    trap 'rm -rf -- "$build_dir"' EXIT
    git clone https://aur.archlinux.org/yay.git "$build_dir/yay"
    makepkg --dir "$build_dir/yay" -si --noconfirm
    trap - EXIT
    rm -rf -- "$build_dir"
}

install_yay
yay -Syu --noconfirm --needed zen-browser-bin grimblast

echo 'Configuring services...'
sudo install -d -m 0755 /etc/sddm.conf.d
printf '[Autologin]\nUser=%s\nSession=hyprland\nRelogin=true\n' "$USER" |
    sudo tee /etc/sddm.conf.d/autologin.conf >/dev/null
sudo systemctl enable --force sddm.service
sudo systemctl enable --now cups.service

link_file() {
    local src="$1" dst="$2"

    if [[ ! -e "$src" ]]; then
        printf 'WARNING: source missing, skipping: %s\n' "$src"
        return 0
    fi

    mkdir -p "$(dirname "$dst")"
    if [[ -e "$dst" && ! -L "$dst" ]]; then
        local backup="${dst}.bak.$(date +%Y%m%d%H%M%S)"
        printf 'Backing up: %s -> %s\n' "$dst" "$backup"
        mv -- "$dst" "$backup"
    fi

    ln -sfn -- "$src" "$dst"
    [[ "$(readlink -f "$dst")" == "$(realpath "$src")" ]]
    printf 'Linked: %s -> %s\n' "$dst" "$src"
}

echo 'Linking configuration files...'
link_file "$BASE/.config/dunst/dunstrc" "$HOME/.config/dunst/dunstrc"
link_file "$BASE/.config/fastfetch/config.jsonc" "$HOME/.config/fastfetch/config.jsonc"
link_file "$BASE/.config/ghostty/config" "$HOME/.config/ghostty/config"
link_file "$BASE/.config/mpd/mpd.conf" "$HOME/.config/mpd/mpd.conf"
link_file "$BASE/.config/hypr/wallpaper/firered.png" "$HOME/.config/hypr/wallpaper/firered.png"
link_file "$BASE/.config/hypr/hyprland.conf" "$HOME/.config/hypr/hyprland.conf"
link_file "$BASE/.config/hypr/hyprlock.conf" "$HOME/.config/hypr/hyprlock.conf"
link_file "$BASE/.config/hypr/hyprpaper.conf" "$HOME/.config/hypr/hyprpaper.conf"
link_file "$BASE/.config/waybar/config.jsonc" "$HOME/.config/waybar/config.jsonc"
link_file "$BASE/.config/waybar/style.css" "$HOME/.config/waybar/style.css"
link_file "$BASE/.local/bin/get-color" "$HOME/.local/bin/get-color"
link_file "$BASE/.local/bin/terminal-launcher" "$HOME/.local/bin/terminal-launcher"
link_file "$BASE/.local/bin/gpg_crd_cmds.txt" "$HOME/.local/bin/gpg_crd_cmds.txt"
link_file "$BASE/.local/bin/gpgcli" "$HOME/.local/bin/gpgcli"
link_file "$BASE/.local/share/fonts/PressStart2P-Regular.ttf" \
    "$HOME/.local/share/fonts/PressStart2P-Regular.ttf"
link_file "$BASE/.bashrc" "$HOME/.bashrc"
link_file "$BASE/.clang-format" "$HOME/.clang-format"
link_file "$BASE/.drirc" "$HOME/.drirc"
link_file "$BASE/.inputrc" "$HOME/.inputrc"
link_file "$BASE/.vimrc" "$HOME/.vimrc"
mkdir -p "$HOME/Music" "$HOME/.config/mpd/playlists"
fc-cache -f "$HOME/.local/share/fonts" >/dev/null 2>&1 || true

echo 'Creating Python virtual environment...'
if [[ ! -f "$HOME/.env/bin/activate" ]]; then
    if [[ -e "$HOME/.env" ]]; then
        backup="$HOME/.env.bak.$(date +%Y%m%d%H%M%S)"
        printf 'Backing up incomplete virtual environment: %s -> %s\n' "$HOME/.env" "$backup"
        mv -- "$HOME/.env" "$backup"
    fi
    python -m venv "$HOME/.env"
fi

echo 'Installing Vim plugins and language tooling...'
source "$HOME/.env/bin/activate"
mkdir -p "$HOME/.cache/vim/backup" "$HOME/.cache/vim/swap" "$HOME/.cache/vim/undo" "$HOME/tags"
curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -Nu "$HOME/.vimrc" -n -es +PlugInstall +qall
python -m pip install --upgrade pip jedi-language-server
deactivate

# Do the Wi-Fi handoff last. Stopping standalone iwd can briefly interrupt
# connectivity, so all pacman, AUR, curl, and pip work must finish first.
# NetworkManager can then start and own iwd through its configured backend.
echo 'Activating desktop and network services...'
sudo systemctl enable --now power-profiles-daemon.service bluetooth.service
if command -v iwctl >/dev/null 2>&1 || systemctl is-active --quiet iwd.service; then
    sudo install -d -m 0755 /etc/NetworkManager/conf.d
    printf '[device]\nwifi.backend=iwd\n' |
        sudo tee /etc/NetworkManager/conf.d/wifi_backend.conf >/dev/null
    sudo systemctl disable --now iwd.service 2>/dev/null || true
    sudo systemctl disable --now systemd-networkd.service systemd-networkd.socket 2>/dev/null || true
    sudo systemctl enable --now NetworkManager.service
    sudo systemctl restart NetworkManager.service
else
    sudo systemctl disable --now systemd-networkd.service systemd-networkd.socket 2>/dev/null || true
    sudo systemctl enable --now NetworkManager.service
fi
if [[ -n "${XDG_RUNTIME_DIR:-}" && -S "$XDG_RUNTIME_DIR/bus" ]]; then
    systemctl --user enable --now pipewire.socket pipewire-pulse.socket wireplumber.service
else
    echo 'Skipping PipeWire user services: no user D-Bus session is available.'
    echo 'They will start automatically when you log into the graphical session.'
fi

echo 'Arch setup complete. Reboot to start SDDM and Hyprland.'
