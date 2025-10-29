#!/bin/sh

default=(
  padding_left=5
  padding_right=5
  icon.font="Hack Nerd Font:Bold:17.0"
  label.font="SF Pro:Semibold:14.0"
  icon.color=0xffffffff
  label.color=0xffffffff
  icon.padding_left=10
  icon.padding_right=4
  label.padding_left=4
  label.padding_right=5
  background.padding_right=5
)
sketchybar --default "${default[@]}"

sketchybar --add event aerospace_workspace_change





