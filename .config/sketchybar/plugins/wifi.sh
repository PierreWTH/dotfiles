#!/bin/sh

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

WIFI=$(ipconfig getsummary en0 | awk -F ' SSID : ' '/ SSID : / {print $2}')

if [[ $WIFI != "" ]]; then
  LABEL=$WIFI
fi

IP_ADDRESS=$(scutil --nwi | grep address | sed 's/.*://' | tr -d ' ' | head -1)
VPN=$(scutil --nwi | grep -m1 'VPN' | awk '{ print $4 }')

if [[ $WIFI != "" ]]; then
  ICON=$ICON_WIFI_CONNECTED
  LABEL=$WIFI
elif [[ $IP_ADDRESS != "" ]]; then
  ICON=$ICON_WIFI_CONNECTED
  LABEL="on"
else
  ICON=$ICON_WIFI_DISCONNECTED
  LABEL="off"
fi

sketchybar --set wifi icon=$ICON
