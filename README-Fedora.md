# Fedora Setup
Extremely Easy Linux Installation &amp; Post-Install Setup Guide (Fedora)

## Prepare USB

1. Download Ventoy and install it onto your USB
   →https://www.ventoy.net/en/download.html
2. Download Fedora KDE Plasma iso and sig(Or ask me for it) (x68_64)
   →https://www.fedoraproject.org/kde/download
3. Copy the verified fedora.iso file onto the USB

---

## Reboot PC into USB

1. Shut down → Turn on
2. Follow on-screen instructions for booting into USB
3. Choose **Temporary startup device** (usually F12) → Choose your USB
3. Screen should show **VENTOY**
4. Select **Fedora-KDE-Desktop-Live-*release*-x86_64.iso** → Enter → **Boot in normal mode** → Enter

---

1. Once booted into USB, select top option.
   You should now see two options, choose top.
2. Finish the install.

---

## After First Successful Boot

1. Connect to Wi-Fi or Ethernet  
2. Open **Konsole** and run the following commands one by one:

```bash
git config --global commit.gpgsign true
cd; git clone https://github.com/brianspragge/personal.git
sudo dnf install vim git
```

> Copy files from the personal/fedora/ directory to ~/

---

## Import Custom KDE Keyboard Shortcuts

1. Open **System Settings** → Search "Shortcuts" (Configure Keyboard Shortcuts)  
2. Top right → **Import** → **Custom Scheme**  
3. Click **Select File** → Choose `~/personal/fedora/kde-keybind-schema.kksrc`  
4. Click **Apply**

---

## KDE Appearance Tweaks

2. **Window Management → Desktop Effects**  
   - Enable **Dim Inactive**  

3. **Task Switcher**  
   - Change from "Thumbnail Grid" to **Large Icons**  

4. **Window Behavior**  
   - Activation policy: **Focus follows mouse (mouse precedence)**  
   - Delay focus: **100 ms**  
   - Enable **Raise on hover**, delay: **500 ms**  

5. **Window Actions**  
   - Mouse wheel on titlebar: **Change opacity**  

6. **Virtual Desktops**  
   - **Add Desktop** until there are nine desktops
   - Enable navigation wrap around
   - Disable switching animation
   - On-screen display when switching: **100 ms**
   - Disable desktop layout indicators

7. **Screen Borders**
   - Make changes in that settings area
   - *Trigger quarter tiling in: Outer* '20%' *of the screen*
   - Disable *Corner barrier*
   - Change *Edge barrier* to 'None'

---

## Konsole Behavior Settings

1. **Settings → General**
   - Enable *Remove window titlebar and frame*
   - Enable *Focus terminals when the mouse pointer is moved over them*

2. **Profiles**
   - Create *+ New...* profile 'Main'

3. **Edit... → Semantic Integration**
   - Enable *Mouse click in input line moves cursor*
 
4. **Appearance**
   - Change font size from '10' to '12'

5. **Cursor → Color:**
   - Enable *Custom cursor color*

6. **Miscellaneous → Active Terminals:**
   - Enable *Border*

7. **Scrolling**
   - Change *Scrollback* from '1000' to '10,000'
   - Change *Scrollbar position* from 'Right side' to 'Hidden'

8. **Screen Locking**
   - Change *Lock screen automatically:* from '5sec' to '15min'

9. **Keyboard**
   - Change 'Key repeat' from '600ms' to '200'
   - Change 'Rate:' from '25' to '30' → **Key Bindings**
   - Enable 'Configure keyboard options' → *Ctrl position* Enable
   - 'Caps Lock as Ctrl'

---

## Final Step

Update Fedora and reboot.

**FINISHED!**  
Congratulations, you are now using Fedora in a very **Stylish** way! 
