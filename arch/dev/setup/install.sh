#!/usr/bin/env bash
set -euo pipefail

# Install the bare-Arch profile: packages, services, and user configuration.
# Run as the normal user from any directory.
#
# Options:
#   --config-only   Only install user config files; skip packages and services.
#   --no-packages   Skip package installation; still configure services.
#   --tags          Regenerate Vim ctags for C++, Python, Go, and Rust.
#   -h, --help      Show this help.

CONFIG_ONLY=0
INSTALL_PACKAGES=1
CONFIGURE_SYSTEM=1
GENERATE_TAGS=0

usage() {
    sed -n '4,12p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
}

while (($#)); do
    case "$1" in
        --config-only)
            CONFIG_ONLY=1
            INSTALL_PACKAGES=0
            CONFIGURE_SYSTEM=0
            ;;
        --no-packages)
            INSTALL_PACKAGES=0
            ;;
        --tags)
            GENERATE_TAGS=1
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            printf 'Unknown option: %s\n\n' "$1" >&2
            usage >&2
            exit 1
            ;;
    esac
    shift
done

if [[ "$EUID" -eq 0 ]]; then
    printf '%s\n' 'Run this script as your normal user; it uses sudo when needed.' >&2
    exit 1
fi
if [[ "$INSTALL_PACKAGES" -eq 1 || "$CONFIGURE_SYSTEM" -eq 1 ]]; then
    if ! command -v sudo >/dev/null 2>&1; then
        printf '%s\n' 'sudo is required. Install it and grant this user sudo access first.' >&2
        exit 1
    fi
    sudo -v
fi

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
BASE="$(cd -- "$SCRIPT_DIR/../user" && pwd)"

install_packages() {
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
        polkit-kde-agent chromium \
        eza btop cowsay catimg nvm rustup bash-completion \
        pipewire pipewire-audio pipewire-pulse wireplumber \
        ttf-jetbrains-mono-nerd otf-font-awesome ttf-nerd-fonts-symbols \
        fastfetch pkgstats \
        python python-pip clang ctags nodejs npm bash-language-server gnupg

    if ! rustup toolchain list 2>/dev/null | grep -q '^stable'; then
        rustup default stable
    fi

    install_yay
    yay -Syu --noconfirm --needed zen-browser-bin grimblast
}

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

configure_system() {
    echo 'Configuring services...'
    sudo install -d -m 0755 /etc/sddm.conf.d
    printf '[Autologin]\nUser=%s\nSession=hyprland\nRelogin=true\n' "$USER" |
        sudo tee /etc/sddm.conf.d/autologin.conf >/dev/null
    sudo systemctl enable --force sddm.service
    sudo systemctl enable --now cups.service

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
}

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

remove_obsolete_link() {
    local dst="$1"

    if [[ -L "$dst" ]]; then
        printf 'Removing obsolete link: %s -> %s\n' "$dst" "$(readlink "$dst")"
        rm -f -- "$dst"
    elif [[ -e "$dst" ]]; then
        printf 'WARNING: obsolete path is a real file, leaving it: %s\n' "$dst"
    fi
}

install_desktop_files() {
    local src dst tmp encoded_home

    # Chromium encodes file:// paths in StartupWMClass as __home_user_.
    encoded_home="__${HOME#/}"
    encoded_home="${encoded_home//\//_}_"

    mkdir -p "$HOME/.local/share/applications"
    for src in "$BASE/.local/share/applications"/*.desktop; do
        [[ -e "$src" ]] || continue
        dst="$HOME/.local/share/applications/$(basename "$src")"
        tmp="$(mktemp)"
        sed -e "s|/home/bms|$HOME|g" \
            -e "s|__home_bms_|$encoded_home|g" \
            -e "s|omarchy-launch-webapp|$HOME/.local/bin/webapp-launcher|g" \
            "$src" >"$tmp"
        chmod 0644 "$tmp"
        if [[ -f "$dst" ]] && cmp -s "$tmp" "$dst"; then
            rm -f -- "$tmp"
            printf 'Launcher already current: %s\n' "$dst"
            continue
        fi
        if [[ -e "$dst" && ! -L "$dst" ]]; then
            local backup="${dst}.bak.$(date +%Y%m%d%H%M%S)"
            printf 'Backing up: %s -> %s\n' "$dst" "$backup"
            mv -- "$dst" "$backup"
        fi
        mv -f -- "$tmp" "$dst"
        printf 'Installed launcher: %s\n' "$dst"
    done
}

link_desktop_assets() {
    local src dst

    for src in "$BASE/.local/share/applications/icons"/*; do
        [[ -e "$src" ]] || continue
        dst="$HOME/.local/share/applications/icons/$(basename "$src")"
        link_file "$src" "$dst"
    done
    link_file "$BASE/.local/share/applications/Fx-570es_plus-1.png" \
        "$HOME/.local/share/applications/Fx-570es_plus-1.png"
}

link_vim_thesaurus() {
    local src dst

    for src in "$BASE/.vim/thesaurus"/*; do
        [[ -e "$src" ]] || continue
        dst="$HOME/.vim/thesaurus/$(basename "$src")"
        link_file "$src" "$dst"
    done
}

configure_git_signing() {
    echo 'Configuring git signing...'
    if ! command -v git >/dev/null 2>&1; then
        echo 'Skipping git signing: git is not installed.'
        return
    fi
    if ! command -v gpg >/dev/null 2>&1 ||
        ! gpg --list-secret-keys --with-colons 2>/dev/null | grep -q '^sec'; then
        echo 'Skipping git signing: no GPG secret key found.'
        return
    fi

    git config --global commit.gpgsign true
    git config --global commit.signoff true
    git config --global tag.gpgsign true
    git config --global log.showSignature true
    echo 'Enabled commit/tag signing and signature display.'
}

generate_tags() {
    if ! command -v ctags >/dev/null 2>&1; then
        echo 'Skipping ctags: ctags is not installed.'
        return
    fi

    echo 'Generating Vim ctags...'
    mkdir -p "$HOME/.vim/tags"

    echo '  C++ tags from /usr/include (this takes a while)...'
    ctags -R --languages=C,C++ --fields=+iaS --extras=+q \
        -f "$HOME/.vim/tags/cpp.tags" /usr/include 2>/dev/null || true

    local pystdlib
    pystdlib="$(python -c "import sysconfig; print(sysconfig.get_path('stdlib'))" 2>/dev/null || true)"
    if [[ -n "$pystdlib" ]]; then
        echo '  Python stdlib tags...'
        ctags -R --languages=Python --fields=+iaS --extras=+q \
            -f "$HOME/.vim/tags/python_stdlib.tags" "$pystdlib" 2>/dev/null || true
    fi

    if command -v go >/dev/null 2>&1; then
        local goroot
        goroot="$(go env GOROOT 2>/dev/null || true)"
        if [[ -n "$goroot" && -d "$goroot/src" ]]; then
            echo '  Go stdlib tags...'
            ctags -R --languages=Go --fields=+iaS --extras=+q \
                -f "$HOME/.vim/tags/go_stdlib.tags" "$goroot/src" 2>/dev/null || true
        fi
    fi

    if command -v rustc >/dev/null 2>&1; then
        local rustlib
        rustlib="$(rustc --print sysroot 2>/dev/null || true)"
        if [[ -n "$rustlib" && -d "$rustlib/lib/rustlib/src/rust/library" ]]; then
            echo '  Rust stdlib tags...'
            ctags -R --languages=Rust --fields=+iaS --extras=+q \
                -f "$HOME/.vim/tags/rust_stdlib.tags" \
                "$rustlib/lib/rustlib/src/rust/library" 2>/dev/null || true
        fi
    fi

    echo 'Tags written to ~/.vim/tags/'
}

if [[ "$INSTALL_PACKAGES" -eq 1 ]]; then
    install_packages
fi
if [[ "$CONFIGURE_SYSTEM" -eq 1 ]]; then
    configure_system
fi

echo 'Linking configuration files...'
link_file "$BASE/.config/dunst/dunstrc" "$HOME/.config/dunst/dunstrc"
link_file "$BASE/.config/fastfetch/config.jsonc" "$HOME/.config/fastfetch/config.jsonc"
link_file "$BASE/.config/ghostty/config" "$HOME/.config/ghostty/config"
link_file "$BASE/.config/mpd/mpd.conf" "$HOME/.config/mpd/mpd.conf"
link_file "$BASE/.config/opencode/cli.json" "$HOME/.config/opencode/cli.json"
link_file "$BASE/.config/terminal-colors.d/cal.scheme" "$HOME/.config/terminal-colors.d/cal.scheme"
rm -f "$HOME/.config/hypr/wallpaper/firered.png"
link_file "$BASE/.config/hypr/wallpaper/jade.png" "$HOME/.config/hypr/wallpaper/jade.png"
for module in hyprland monitors input looknfeel bindings programs; do
    link_file "$BASE/.config/hypr/$module.lua" "$HOME/.config/hypr/$module.lua"
done
link_file "$BASE/.config/hypr/hyprlock.conf" "$HOME/.config/hypr/hyprlock.conf"
link_file "$BASE/.config/hypr/hyprpaper.conf" "$HOME/.config/hypr/hyprpaper.conf"
link_file "$BASE/.config/waybar/config.jsonc" "$HOME/.config/waybar/config.jsonc"
link_file "$BASE/.config/waybar/style.css" "$HOME/.config/waybar/style.css"
link_file "$BASE/.local/bin/get-color" "$HOME/.local/bin/get-color"
link_file "$BASE/.local/bin/getcolor" "$HOME/.local/bin/getcolor"
link_file "$BASE/.local/bin/terminal-launcher" "$HOME/.local/bin/terminal-launcher"
link_file "$BASE/.local/bin/webapp-launcher" "$HOME/.local/bin/webapp-launcher"
link_file "$BASE/.local/bin/gpg_crd_cmds.txt" "$HOME/.local/bin/gpg_crd_cmds.txt"
link_file "$BASE/.local/bin/gpg_ref.txt" "$HOME/.local/bin/gpg_ref.txt"
link_file "$BASE/.local/bin/gpgcli" "$HOME/.local/bin/gpgcli"
link_file "$BASE/.local/share/fonts/PressStart2P-Regular.ttf" \
    "$HOME/.local/share/fonts/PressStart2P-Regular.ttf"
link_file "$BASE/Pictures/Macbaconai-floating-oriental-roofing-island.jpeg" \
    "$HOME/Pictures/Macbaconai-floating-oriental-roofing-island.jpeg"
link_file "$BASE/.bashrc" "$HOME/.bashrc"
link_file "$BASE/.clang-format" "$HOME/.clang-format"
link_file "$BASE/.drirc" "$HOME/.drirc"
link_file "$BASE/.inputrc" "$HOME/.inputrc"
link_file "$BASE/.vimrc" "$HOME/.vimrc"

echo 'Installing personal launchers...'
install_desktop_files
link_desktop_assets
link_vim_thesaurus

remove_obsolete_link "$HOME/.config/hypr/hyprland.conf"
remove_obsolete_link "$HOME/.config/hypr/hyprlandPersonal.conf"

mkdir -p "$HOME/Music" "$HOME/.config/mpd/playlists"
fc-cache -f "$HOME/.local/share/fonts" >/dev/null 2>&1 || true

configure_git_signing

if [[ "$GENERATE_TAGS" -eq 1 ]]; then
    generate_tags
fi

if [[ "$CONFIG_ONLY" -eq 0 ]]; then
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
    mkdir -p "$HOME/.cache/vim/backup" "$HOME/.cache/vim/swap" "$HOME/.cache/vim/undo"
    curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim -Nu "$HOME/.vimrc" -n -es +PlugInstall +qall
    python -m pip install --upgrade pip jedi-language-server
    deactivate
fi

if [[ -n "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]] && command -v hyprctl >/dev/null 2>&1; then
    echo 'Reloading Hyprland...'
    hyprctl reload || true
fi

if [[ "$CONFIG_ONLY" -eq 1 ]]; then
    echo 'Configuration installed.'
else
    echo 'Arch setup complete. Reboot to start SDDM and Hyprland.'
fi
