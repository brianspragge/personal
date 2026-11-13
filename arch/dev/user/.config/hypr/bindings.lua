-- Keybindings.
--
-- Personal layout, ported from the Omarchy profile but using only native
-- Hyprland dispatchers and standard Arch utilities.

local programs = require("programs")

local mainMod = "SUPER"

-- Applications ---------------------------------------------------------------

hl.bind(mainMod .. " + SHIFT + RETURN", hl.dsp.exec_cmd(programs.terminal),
    { description = "Terminal" })
hl.bind(mainMod .. " + ALT + RETURN", hl.dsp.exec_cmd(programs.terminal .. " -e tmux new"),
    { description = "Tmux" })
hl.bind(mainMod .. " + SHIFT + Q",
    hl.dsp.exec_cmd(programs.terminal .. " --hold sh -c fastfetch"),
    { description = "Fastfetch" })
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(programs.browser), { description = "Browser" })
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd(programs.privateBrowser),
    { description = "Private browser" })
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(programs.fileManager), { description = "File manager" })
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(programs.menu), { description = "Application menu" })
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.exec_cmd("gimp"), { description = "GIMP" })
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd(programs.terminal .. " -e btop"),
    { description = "Activity monitor" })

-- Web apps -------------------------------------------------------------------

hl.bind(mainMod .. " + SHIFT + M",
    hl.dsp.exec_cmd(programs.webapp .. " https://messenger.com"),
    { description = "Messenger" })
hl.bind(mainMod .. " + SHIFT + I",
    hl.dsp.exec_cmd(programs.webapp .. " https://instagram.com"),
    { description = "Instagram" })
hl.bind(mainMod .. " + SHIFT + W",
    hl.dsp.exec_cmd(programs.webapp .. " https://web.whatsapp.com/"),
    { description = "WhatsApp" })
hl.bind(mainMod .. " + SHIFT + Y",
    hl.dsp.exec_cmd(programs.webapp .. " https://youtube.com/"),
    { description = "YouTube" })

-- Screenshots ----------------------------------------------------------------

hl.bind("Print", hl.dsp.exec_cmd("grimblast copysave output"),
    { description = "Screenshot output" })
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("grimblast copysave area"),
    { description = "Screenshot area" })
hl.bind(mainMod .. " + SHIFT + Print", hl.dsp.exec_cmd("grimblast edit output"),
    { description = "Screenshot edit" })

-- Window management ----------------------------------------------------------

hl.bind(mainMod .. " + Q", hl.dsp.window.close(), { description = "Close window" })
hl.bind(mainMod .. " + M", hl.dsp.exit(), { description = "Exit Hyprland" })
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = 1 }),
    { description = "Fullscreen" })
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }),
    { description = "Toggle floating" })
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo(), { description = "Pseudo tiling" })
hl.bind(mainMod .. " + CTRL + J", hl.dsp.layout("togglesplit"),
    { description = "Toggle split" })
hl.bind(mainMod .. " + CTRL + ALT + L",
    hl.dsp.exec_cmd([[hyprctl eval 'local l = hl.get_config("general.layout"); hl.config({ general = { layout = (l == "dwindle" and "master" or "dwindle") } })']]),
    { description = "Toggle Dwindle/Master layout" })

-- Move focus with SUPER + hjkl.
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }), { description = "Focus left" })
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }), { description = "Focus right" })
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }), { description = "Focus up" })
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }), { description = "Focus down" })

-- Swap the active window with its neighbour.
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.swap({ direction = "l" }),
    { description = "Swap window left" })
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.swap({ direction = "r" }),
    { description = "Swap window right" })
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.swap({ direction = "u" }),
    { description = "Swap window up" })
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.swap({ direction = "d" }),
    { description = "Swap window down" })

-- Resize the active window.
hl.bind(mainMod .. " + ALT + L", hl.dsp.window.resize({ x = 100, y = 0, relative = true }),
    { description = "Expand window left" })
hl.bind(mainMod .. " + ALT + H", hl.dsp.window.resize({ x = -100, y = 0, relative = true }),
    { description = "Shrink window left" })
hl.bind(mainMod .. " + ALT + K", hl.dsp.window.resize({ x = 0, y = -100, relative = true }),
    { description = "Shrink window up" })
hl.bind(mainMod .. " + ALT + J", hl.dsp.window.resize({ x = 0, y = 100, relative = true }),
    { description = "Expand window down" })

-- Scratchpad.
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("scratchpad"),
    { description = "Toggle scratchpad" })
hl.bind(mainMod .. " + SHIFT + S",
    hl.dsp.window.move({ workspace = "special:scratchpad", follow = true }),
    { description = "Move window to scratchpad" })
hl.bind(mainMod .. " + ALT + S",
    hl.dsp.window.move({ workspace = "special:scratchpad", follow = false }),
    { description = "Move window silently to scratchpad" })

-- Workspaces -----------------------------------------------------------------

for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }),
        { description = "Workspace " .. i })
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }),
        { description = "Move window to workspace " .. i })
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }),
    { description = "Next workspace" })
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }),
    { description = "Previous workspace" })

-- Mouse bindings -------------------------------------------------------------

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Media and hardware keys ----------------------------------------------------

hl.bind("XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 10%+"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"),
    { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Desktop tweaks -------------------------------------------------------------

hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("killall -SIGUSR1 waybar"),
    { description = "Toggle waybar visibility" })
hl.bind(mainMod .. " + CTRL + W", hl.dsp.exec_cmd("killall -SIGUSR2 waybar"),
    { description = "Toggle waybar mode" })
hl.bind(mainMod .. " + CTRL + D", hl.dsp.exec_cmd("killall dunst; dunst &"),
    { description = "Restart dunst" })
hl.bind(mainMod .. " + CTRL + P",
    hl.dsp.exec_cmd([[mon=$(hyprctl monitors | awk '/^Monitor / {print $2; exit}'); hyprctl hyprpaper wallpaper "$mon,]] .. programs.wallpaper .. [["]]),
    { description = "Reload wallpaper" })
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("$HOME/.local/bin/get-color"),
    { description = "Pick colour from screen" })
