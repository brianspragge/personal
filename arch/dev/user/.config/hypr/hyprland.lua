-- Hyprland configuration for bare Arch Linux.
--
-- This is a native Hyprland Lua config (Hyprland 0.57+), split into modules by
-- concern. It has no dependency on Omarchy: every command here is a standard
-- Hyprland or Arch utility.
--
-- Validate without restarting the compositor:
--   Hyprland --verify-config -c ~/.config/hypr/hyprland.lua

require("monitors")
require("input")
require("looknfeel")
require("bindings")

local programs = require("programs")

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("dunst")
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
    hl.exec_cmd("systemctl --user start pipewire.socket pipewire-pulse.socket wireplumber.service")
    hl.exec_cmd("systemctl --user start mpd.service")

    hl.exec_cmd("[workspace 1 silent] " .. programs.terminal)
    hl.exec_cmd("[workspace 2 silent] " .. programs.terminal)
    hl.exec_cmd("[workspace 3 silent] " .. programs.browser)
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- X230 (Ivy Bridge) VA-API. Uncomment on that hardware only.
-- hl.env("LIBVA_DRIVER_NAME", "i965")

-----------------------
----- PERMISSIONS -----
-----------------------

-- hl.config({ ecosystem = { enforce_permissions = true } })
-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- Ignore maximize requests from all apps.
hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix dragging issues with XWayland.
hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})
