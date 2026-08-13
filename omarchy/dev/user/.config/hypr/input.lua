-- Control your input devices
-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input

hl.config({
  input = {
    kb_layout = "us",
    kb_options = "ctrl:nocaps,compose:ralt",
    repeat_rate = 25,
    repeat_delay = 200,
    numlock_by_default = true,
    sensitivity = 0,
    touchpad = {
      natural_scroll = true,
      scroll_factor = 0.3,
    },
  },
})

-- Scroll nicely in the terminal
o.window("(Alacritty|kitty|foot)", { scroll_touchpad = 1.5 })
o.window("com.mitchellh.ghostty", { scroll_touchpad = 0.2 })

-- Enable touchpad gestures for changing workspaces
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
-- hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
