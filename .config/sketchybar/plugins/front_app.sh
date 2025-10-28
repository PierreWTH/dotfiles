#!/bin/sh

if [ "$SENDER" = "front_app_switched" ]; then
  ICON=$("$CONFIG_DIR/plugins/icon_map_fn.sh" "$INFO")
  echo "$INFO $ICON $NAME" >> /tmp/sketchybar_front_app.log 
  sketchybar --set "$NAME" label="$INFO" icon="$ICON"
fi
