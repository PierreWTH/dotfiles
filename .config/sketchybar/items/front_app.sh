#!/bin/bash

sketchybar --add item front_app left \
  --set front_app background.color="0x00000000" \
  background.border_width=1 \
  background.border_color="0xffffffff" \
  background.corner_radius=5 \
  background.height=24 \
  background.padding_left=10 \
  background.padding_right=10 \
  icon.color="0xffffffff" \
  icon.font="sketchybar-app-font:Regular:16.0" \
  icon.padding_left=8 \
  icon.padding_right=8 \
  label.color="0xffffffff" \
  label.padding_left=8 \
  label.padding_right=8 \
  script="$PLUGIN_DIR/front_app.sh" \
  --subscribe front_app front_app_switched