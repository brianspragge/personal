#!/usr/bin/env bash

# Many thanks to Bread On Penguins, I used their outline for my own here.

TMP="/tmp/color.png"
read X Y <<< "$(hyprctl cursorpos | tr -d ' ' | tr ',' ' ')"
grim -g "${X},${Y} 1x1" "$TMP"
read R G B A <<< "$(magick "$TMP" -format "%[fx:int(255*r)] %[fx:int(255*g)] %[fx:int(255*b)] %[fx:int(255*a)]" info:)"
# For alpha colors:
COLOR=$(printf "#%02X%02X%02X%02X" "$R" "$G" "$B" "$A")
# For hex colors:
#COLOR=$(printf "#%02X%02X%02X" "$R" "$G" "$B")
notify-send -i "$TMP" "Color: $COLOR" "X:$X Y:$Y"
echo -n "$COLOR" | wl-copy
rm "$TMP"

