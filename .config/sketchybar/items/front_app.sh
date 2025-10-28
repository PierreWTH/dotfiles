#!/bin/bash

sketchybar --add item front_app left \
  --set front_app background.color=0x44ffffff \
  background.corner_radius=6 \
  background.height=24 \
  background.drawing=on \
  icon.color="0xffffffff" \
  icon.font="sketchybar-app-font:Regular:16.0" \
  icon.padding_left=8 \
  icon.padding_right=8 \
  label.color="0xffffffff" \
  label.padding_left=5 \
  label.padding_right=8 \
  padding_left=8 \
  script="$PLUGIN_DIR/front_app.sh" \
  --subscribe front_app front_app_switched