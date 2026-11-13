-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local monitor_scale = 1

hl.env("GDK_SCALE", tostring(monitor_scale))

-- Fallback for any output not listed below.
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = monitor_scale })

-- ThinkPad X230 + external display.
hl.monitor({ output = "LVDS-1", mode = "1366x768@60", position = "0x0", scale = monitor_scale })
hl.monitor({ output = "DP-1", mode = "1920x1080@60", position = "1366x-850", scale = monitor_scale })
-- The laptop only keeps workspace 1; external displays get workspaces 2-10.
-- hl.workspace_rule({ workspace = "1", monitor = "DP-1" })
-- for ws = 2, 10 do
--   hl.workspace_rule({ workspace = tostring(ws), monitor = "DP-2" })
-- end

-- ThinkPad X13 + external display.
hl.monitor({ output = "eDP-1", mode = "1920x1200@60.003", position = "0x0", scale = monitor_scale })
hl.monitor({ output = "DP-2", mode = "1920x1080@60", position = "-1920x0", scale = monitor_scale })
-- The laptop only keeps workspace 10; external displays get workspaces 1-9.
hl.workspace_rule({ workspace = "10", monitor = "eDP-1" })
for ws = 1, 9 do
    hl.workspace_rule({ workspace = tostring(ws), monitor = "DP-2" })
end
