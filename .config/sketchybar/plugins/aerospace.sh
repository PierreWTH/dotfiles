#!/usr/bin/env bash

source "$HOME/.config/sketchybar/colors.sh"

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME label.color=$COLOR_CYAN
else
  sketchybar --set $NAME label.color=$COLOR_WHITE
fi
