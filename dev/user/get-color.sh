#!/usr/bin/env bash

eval "$(xdotool getmouselocation --shell)"
COLOR=$(import -window root -crop 1x1+$X+$Y txt:- | grep -om1 '#\w\+')
notify-send "Color under cursor: $COLOR"

