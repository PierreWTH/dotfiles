#!/bin/sh

##### Left Items #####

sketchybar --add event aerospace_workspace_change \
  --add item apple left --set apple background.border_width=1 \
                                    background.height=24 \
                                    background.corner_radius=8 \
                                    background.color=0x44ffffff \
                                    icon.padding_left=8 \
                                    icon.padding_right=8 \
                                    padding_left=0 \
                                    padding_right=10 \
                                    label.drawing=off \
                                    icon=$ICON_APPLE

for sid in $(aerospace list-workspaces --all); do
  sketchybar --add item space.$sid left \
    --subscribe space.$sid aerospace_workspace_change \
    --set space.$sid \
    background.color=0x44ffffff \
    background.corner_radius=6 \
    background.height=23 \
    background.drawing=off \
    label="$sid" \
    label.padding_left=8 \
    label.padding_right=8 \
    padding_left=2 \
    padding_right=2 \
    icon.drawing=off \
    click_script="aerospace workspace $sid" \
    script="$CONFIG_DIR/plugins/aerospace.sh $sid"
done

sketchybar --add item chevron left \
  --set chevron icon="|" label.drawing=off padding_left=6 padding_right=6 \
  --add item front_app left \
  --set front_app script="$PLUGIN_DIR/front_app.sh" \
  --subscribe front_app front_app_switched

sketchybar --add bracket left_bracket '/space\..*/' \
  --set left_bracket background.color=0x44ffffff \
                     background.corner_radius=8 \
                     background.height=24 \
                     background.padding_left=3 \
                     background.padding_right=10

##### Right items #####

sketchybar --add item clock right \
  --set clock update_freq=10 icon=􀧞 script="$PLUGIN_DIR/clock.sh" \
  --add item volume right \
  --set volume script="$PLUGIN_DIR/volume.sh" \
  --subscribe volume volume_change \
  --add item battery right \
  --add item wifi right --set wifi script="$PLUGIN_DIR/wifi.sh" update_freq=5 \
  --set battery update_freq=120 script="$PLUGIN_DIR/battery.sh" \
  --subscribe battery system_woke power_source_change
