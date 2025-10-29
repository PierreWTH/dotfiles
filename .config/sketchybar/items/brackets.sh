#!/bin/bash

sketchybar --add bracket right_bracket cpu clock --set right_bracket background.color=0x44ffffff \
  background.corner_radius=8 \
  background.height=24 \
  background.padding_left=10 \
  background.padding_right=50

sketchybar --add bracket left_bracket '/space\..*/' \
  --set left_bracket background.color=0x44ffffff \
  background.corner_radius=8 \
  background.height=24 \
  background.padding_left=0 \
  background.padding_right=0
