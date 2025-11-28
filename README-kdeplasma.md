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
Connect to Wifi/Ethernet
Open Konsole program and enter each command:
    mkdir ~/builds; cd ~/builds
	git clone https://aur.archlinux.org/yay-bin.git
	cd yay-bin
	makepkg -si
    git config --global commit.gpgsign true
    git clone https://github.com/brianspragge/personal.git
In Start Menu search "Shortcuts"(Configure Keyboard Shortcuts)
    Top right click 'Import'
    Select 'Custom Scheme'
    Click 'Select File'
    Find the file ~/personal/kdeplasma/dev/user/kde-keybind-schema.kksrc
    Click 'Apply'

( Now is the time you may also take whatever else you wish from the  )
( many files in the 'personal' repo. Some good ones I recommend are: )
( .bashrc .vimrc .inputrc /.local/bin/gpgcli                         )

In Start Menu search "Login Screen (SDDM)"(Configure Login Manager)
Click 'Breeze' theme and 'Apply'
Select 'Splash Screen', Apply 'Breeze' theme
Select 'Window Management' then 'Desktop Effects'
    Enable 'Dim Inactive'(Darken inactive windows)
Select 'Task Switcher', Switch 'Thumbnail Grid'
                            to 'Compact'
Select 'Window Behavior', Switch 'Click to focus'
                              to 'Focus follows mouse (mouse precedence)'
    Switch 'Delay focus by:' 300 ms
                          to 100 ms
    Enable 'Raise on hover, delayed by:' Set to 100 ms
Select 'Window Actions', Switch 'Activate, pass click and raise on release'
                             to 'Activate, raise and pass click'
Under 'Inner Window, Titlebar and Frame Actions', Enable 'Mouse wheel:' Set to 'Change opacity'
Search 'Default Applications', Switch 'Web browser' from 'Firefox'
                                                      to 'Chrome'

Enter URL in chrome: chrome://flags
Search "Extensions on chrome"(:// URLs) and 'Enable' it

SUPER + W to add 9 desktops in order to swap windows to them
    (MUST EXIST BEFORE USING 'Move Window to Desktop *')

Enter your FINAL command in Konsole:
    sudo pacman -Syu

FINISHED!  Congratulations, you are now using Arch in a very Stylish way.
