#!/bin/bash

killall waybar


if [[ $(xrandr -q | grep "HDMI-A-1 connected") ]]; then
  hyprctl dispatch exec waybar
else
  hyprctl dispatch exec "waybar -c ~/.config/waybar/config_single.jsonc"
fi
