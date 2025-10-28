#!/usr/bin/env bash

source "$HOME/.config/sketchybar/colors.sh"

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME background.drawing=on \
                         background.color=$COLOR_RED \
                         label.color=$COLOR_WHITE
else
  sketchybar --set $NAME background.drawing=off \
                         label.color=$COLOR_WHITE
fi
