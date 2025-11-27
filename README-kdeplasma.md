Partition			btrfs autosuggested
LUKS				no
Profiles			KDE Plasma
Graphics driver     ALL open-source
Greeter             ssdm
Audio			pipewire
Kernel			linux-lts
Additional packages
				base-devel
				breeze-plymouth
				coreutils
				git
				intel-media-driver
				intel-ucode
				less
                kde-applications
				sddm-kcm
				xdg-user-dirs
				xorg-xwayland

AUR
	mkdir ~/builds; cd ~/builds
	git clone https://aur.archlinux.org/yay-bin.git
	cd yay-bin
	makepkg -si
Git
	git config --global commit.gpgsign true
KDE-Plasma
	Import keybinds and restart
