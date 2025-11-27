Turn off SecureBoot.

Mirrors             United States
Partition			btrfs autosuggested compression
LVM                 no
Disk encryption		no
Btrfs snapshots     no
Swap                Enabled
Bootloader          Systemd-boot
Unified kernel      yes 
Hostname            Example: workstation, homepc, covenant
Authentication      Example: root, password
                             elite,sangheili
                             guest,123
Profile			    KDE Plasma
    Graphics        All open-source
    Greeter         sddm
Applications
    Bluetooth       Enabled
    Audio           pipewire
Kernel			    linux-lts
Network             Use NetworkManager
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
Timezone            America/Los_Angeles
NTP                 Enabled

AFTER FIRST SUCCESSFUL BOOT:
1) Enable Wifi
2) Open Konsole, press enter after each line.
	mkdir ~/builds; cd ~/builds
	git clone https://aur.archlinux.org/yay-bin.git
	cd yay-bin
	makepkg -si
3)  git config --global commit.gpgsign true
4)  git clone https://github.com/brianspragge/personal.git

Search for "Shortcuts"(Configure Keyboard Shortcuts)
Top right click "Import"
Select 'Custom Scheme'
Click 'Select File'
Find the file ~/personal/kdeplasma/dev/user/kde-keybind-schema.kksrc
Click 'Apply'

FINISHED!  Congratulations, you are now using Arch in a very Stylish way.
