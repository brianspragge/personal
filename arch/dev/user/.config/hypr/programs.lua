-- Programs used by the Hyprland configuration. Kept in one place so the main
-- config and the keybindings stay in sync.

return {
    terminal = "$HOME/.local/bin/terminal-launcher",
    fileManager = "dolphin",
    menu = "wofi --show drun",
    browser = "zen-browser",
    privateBrowser = "zen-browser --private-window",
    webapp = "$HOME/.local/bin/webapp-launcher",
    wallpaper = "$HOME/.config/hypr/wallpaper/jade.png",
    lock = "hyprlock",
}
