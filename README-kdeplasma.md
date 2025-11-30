# Extremely Easy Arch Linux Installation & Post-Install Setup Guide

## Installation Settings (Archinstall)

| Option                        | Setting                                      |
|-------------------------------|----------------------------------------------|
| **SecureBoot**                | Turn off SecureBoot                          |
| **Mirrors**                   | United States                                |
| **Partition**                 | BTRFS (autosuggested compression)            |
| **LVM**                       | No                                           |
| **Disk encryption**           | No                                           |
| **Btrfs snapshots**           | No                                           |
| **Swap**                      | Enabled                                      |
| **Bootloader**                | systemd-boot                                 |
| **Unified kernel**            | Yes                                          |
| **Hostname**                  | Example: `workstation` / `laptop` / `homepc` |
| **Authentication**            | Example: `root` / `yourname` / `guest`       |
| **Profile**                   | KDE Plasma                                   |
| **Graphics**                  | All open-source                              |
| **Greeter**                   | SDDM                                         |
| **Applications**              | Bluetooth Enabled                            |
| **Audio**                     | PipeWire                                     |
| **Kernel**                    | `linux-lts`                                  |
| **Network**                   | NetworkManager                               |
| **Additional packages**       | `base-devel breeze-plymouth coreutils git intel-media-driver intel-ucode kde-applications less plymouth-kcm sddm-kcm xdg-user-dirs xorg-xwayland vim` |
| **Timezone**                  | `America/Los_Angeles`                        |
| **NTP**                       | Enabled                                      |

---

## After First Successful Boot

1. Connect to Wi-Fi or Ethernet  
2. Open **Konsole** and run the following commands one by one:

```bash
mkdir ~/builds && cd ~/builds
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
git config --global commit.gpgsign true
git clone https://github.com/brianspragge/personal.git
```

---

## Temporary Plymouth Splash Screen Fix (Remove boot text)

```bash
sudo vim /etc/kernel/cmdline
```
→ Add ` splash quiet` at the end of the line  
→ Press `i` → edit → `Esc` → `:wq` → Enter

---

## Import Custom KDE Keyboard Shortcuts

1. Open **System Settings** → Search "Shortcuts" (Configure Keyboard Shortcuts)  
2. Top right → **Import** → **Custom Scheme**  
3. Click **Select File** → Choose `~/personal/kdeplasma/dev/user/kde-keybind-schema.kksrc`  
4. Click **Apply**

> Optional: Copy useful dotfiles from the `personal` repo to ~/ and ~/.local/bin 
> Recommended: `.bashrc`, `.vimrc`, `.inputrc`, `~/.local/bin/gpgcli`

---

## SDDM & KDE Appearance Tweaks

1. Open **Login Screen (SDDM)**  
   - Theme → **Breeze** → Apply  
   - Splash Screen → **Breeze** → Apply  
   - Boot Splash Screen → **Breeze** → Apply  

2. **Window Management → Desktop Effects**  
   - Enable **Dim Inactive**  

3. **Task Switcher**  
   - Change from "Thumbnail Grid" to **Compact**  

4. **Window Behavior**  
   - Activation policy: **Focus follows mouse (mouse precedence)**  
   - Delay focus: **100 ms**  
   - Enable **Raise on hover**, delay: **100 ms**  

5. **Window Actions**  
   - Inactive Inner Window Actions, Left click: **Activate, raise and pass click**  
   - Mouse wheel on titlebar: **Change opacity**  

6. **Virtual Desktops**  
   - **Add Desktop** until there are nine desktops
   - Enable navigation wrap around
   - Disable switching animation
   - On-screen display when switching: **100 ms**
   - Disable desktop layout indicators

---

## Final Step

```bash
sudo pacman -Syu
reboot
```

**FINISHED!**  
Congratulations, you are now using Arch in a very **Stylish** way! 
