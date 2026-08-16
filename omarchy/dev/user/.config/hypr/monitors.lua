-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

-- Keep Omarchy's knobs intact: omarchy-hyprland-monitor-scaling (SUPER + /)
-- persists into these two locals, and the clamshell handler reads them.
local omarchy_gdk_scale = 2
local omarchy_monitor_scale = "auto"

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- Thinkpad x230 + external display.
-- The laptop only keeps workspace 1; external displays get workspaces 2-10.
-- hl.monitor({ output = "LVDS-1", mode = "1366x768@60", position = "0x0", scale = omarchy_monitor_scale })
-- hl.monitor({ output = "DP-1", mode = "1920x1080@60", position = "1366x-850", scale = omarchy_monitor_scale })
-- hl.workspace_rule({ workspace = "1", monitor = "DP-1" })
-- for ws = 2, 10 do
--   hl.workspace_rule({ workspace = tostring(ws), monitor = "DP-2" })
-- end

-- Thinkpad x13 + external display.
hl.monitor({ output = "eDP-1", mode = "1920x1200@60.003", position = "0x0", scale = omarchy_monitor_scale })
hl.monitor({ output = "DP-2", mode = "1920x1080@60", position = "1920x-850", scale = omarchy_monitor_scale })
-- The laptop only keeps workspace 1; external displays get workspaces 2-10.
hl.workspace_rule({ workspace = "1", monitor = "eDP-1" })
for ws = 2, 10 do
  hl.workspace_rule({ workspace = tostring(ws), monitor = "DP-2" })
end
