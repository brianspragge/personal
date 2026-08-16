-- Personal keybinding overrides. Loaded after Omarchy defaults, so a default
-- that shares a key is unbound first. See: omarchy menu keybindings --print

-- Application bindings -------------------------------------------------------

-- Terminal in the active terminal's cwd (default: Browser).
hl.unbind("SUPER + SHIFT + RETURN")
o.bind("SUPER + SHIFT + RETURN", "Terminal", { omarchy = "terminal" })

-- Tmux in the active terminal's cwd (default: Omarchy's tmux app).
hl.unbind("SUPER + ALT + RETURN")
o.bind("SUPER + ALT + RETURN", "Tmux", "omarchy-launch-terminal tmux new")

-- Gimp (default: Signal).
hl.unbind("SUPER + SHIFT + G")
o.bind("SUPER + SHIFT + G", "Gimp", { launch = "gimp" })

-- Activity monitor.
o.bind("SUPER + SHIFT + T", "Activity", { tui = "btop" })

-- Web apps. If the url contains #, type it as ## so it isn't read as a comment.
hl.unbind("SUPER + SHIFT + M") -- default: Music
o.bind("SUPER + SHIFT + M", "Messenger", { webapp = "https://messenger.com" })

o.bind("SUPER + SHIFT + I", "Instagram", { webapp = "https://instagram.com" })

hl.unbind("SUPER + SHIFT + W") -- default: Omawrite
o.bind("SUPER + SHIFT + W", "WhatsApp", { webapp = "https://web.whatsapp.com/", focus = true })

hl.unbind("SUPER + SHIFT + Y") -- default: YouTube (plain launch)
o.bind("SUPER + SHIFT + Y", "YouTube", { webapp = "https://youtube.com/", focus = true })

-- Window management ----------------------------------------------------------

-- Close window (default close is SUPER + W).
hl.unbind("SUPER + W")
o.bind("SUPER + Q", "Close window", hl.dsp.window.close())

-- Show key bindings on SUPER + CTRL + K (SUPER + K is Omarchy's keybindings,
-- SUPER + CTRL + K is Herdr's keybindings).
hl.unbind("SUPER + K")
hl.unbind("SUPER + CTRL + K")
o.bind("SUPER + CTRL + K", "Show key bindings", "omarchy-menu-keybindings")

-- Move focus with SUPER + hjkl. SUPER + L is Omarchy's workspace-layout
-- toggle, SUPER + J its split toggle; both are moved below.
hl.unbind("SUPER + L")
hl.unbind("SUPER + J")
o.bind("SUPER + H", "Move focus left", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + L", "Move focus right", hl.dsp.focus({ direction = "r" }))
o.bind("SUPER + K", "Move focus up", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + J", "Move focus down", hl.dsp.focus({ direction = "d" }))

-- Toggle split moved to SUPER + CTRL + J (dwindle).
o.bind("SUPER + CTRL + J", "Toggle window split", hl.dsp.layout("togglesplit"))

-- Toggle Dwindle/Master layout (unbound in the Omarchy defaults).
o.bind("SUPER + CTRL + ALT + L", "Toggle Dwindle/Master layout", 'hyprctl eval "hl.config({ general = { layout = \\"$(hyprctl getoption general:layout | grep -q dwindle && echo master || echo dwindle)\\" } })"')

-- Swap active window with the one next to it with SUPER + SHIFT + hjkl.
o.bind("SUPER + SHIFT + H", "Swap window to the left", hl.dsp.window.swap({ direction = "l" }))
o.bind("SUPER + SHIFT + L", "Swap window to the right", hl.dsp.window.swap({ direction = "r" }))
o.bind("SUPER + SHIFT + K", "Swap window up", hl.dsp.window.swap({ direction = "u" }))
o.bind("SUPER + SHIFT + J", "Swap window down", hl.dsp.window.swap({ direction = "d" }))

-- Move window to scratchpad (default: SUPER + ALT + S).
-- SUPER + SHIFT + S is Google Maps keybind
hl.unbind("SUPER + ALT + S")
hl.unbind("SUPER + SHIFT + S")
o.bind("SUPER + SHIFT + S", "Move window to scratchpad", hl.dsp.window.move({ workspace = "special:scratchpad", follow = true }))
o.bind("SUPER + ALT + S", "Move window silently to scratchpad", hl.dsp.window.move({ workspace = "special:scratchpad", follow = false }))

-- Resize active window.
-- SUPER + ALT + K is Omarchy's 'show keybinds' keybind
hl.unbind("SUPER + ALT + K")
o.bind("SUPER + ALT + L", "Expand window left", hl.dsp.window.resize({ x = 100, y = 0, relative = true }))
o.bind("SUPER + ALT + H", "Shrink window left", hl.dsp.window.resize({ x = -100, y = 0, relative = true }))
o.bind("SUPER + ALT + K", "Shrink window up", hl.dsp.window.resize({ x = 0, y = -100, relative = true }))
o.bind("SUPER + ALT + J", "Expand window down", hl.dsp.window.resize({ x = 0, y = 100, relative = true }))
