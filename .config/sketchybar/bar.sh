#!/bin/sh

bar=(
  position=top 
  height=40 
  blur_radius=30 
  color=$COLOR_BACKGROUND
)

sketchybar --bar "${bar[@]}"
