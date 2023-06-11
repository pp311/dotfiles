#!/bin/bash
# Maintain 10 workspaces across multiple monitors
# This script assumes that the monitors are in horizontal layout, correctly setup and in the correct order

# gather monitor count
monitor_count=$(hyprctl monitors -j | jq '. | length')

echo "Configuring for $monitor_count monitors"
if [[ "$monitor_count" == 1 ]]; then
    monitor_1=$(hyprctl monitors -j | jq -r '.[0].name')
    for ((i = 1; i <= 5; i++)); do
        echo "Workspace $i on $monitor_1"
        hyprctl keyword bind SUPER,$i,split-workspace,$i > /dev/null
        hyprctl keyword bind SUPERSHIFT,$i,split-movetoworkspace,$i > /dev/null
    done
    hyprctl keyword workspace $monitor_1,1
elif [[ "$monitor_count" == 2 ]]; then
    monitor_1=$(hyprctl monitors -j | jq -r '.[0].name')
    monitor_2=$(hyprctl monitors -j | jq -r '.[1].name')
    for ((i = 1; i <= 5; i++)); do
      echo "Workspace $(($i + 10)) on $monitor_2"
        hyprctl keyword bind SUPER,$i,split-workspace,$(($i + 10)) > /dev/null
        hyprctl keyword bind SUPERSHIFT,$i,split-movetoworkspace,$(($i + 10)) > /dev/null
        echo "Workspace $i on $monitor_1"
        hyprctl keyword bind SUPER,$(($i + 5)),split-workspace,$i > /dev/null
        hyprctl keyword bind SUPERSHIFT,$(($i + 5)),split-movetoworkspace,$i > /dev/null
    done
    hyprctl keyword bind SUPER,0,split-workspace,5 > /dev/null
    hyprctl keyword bind SUPERSHIFT,0,split-movetoworkspace,5 > /dev/null
    hyprctl keyword workspace $monitor_2,11 > /dev/null
    hyprctl keyword workspace $monitor_1,1 > /dev/null
elif [[ "$monitor_count" == 3 ]]; then
    monitor_1=$(hyprctl monitors -j | jq -r '.[0].name')
    monitor_2=$(hyprctl monitors -j | jq -r '.[1].name')
    monitor_3=$(hyprctl monitors -j | jq -r '.[2].name')
    for ((i = 1; i <= 3; i++)); do
        echo "Workspace $i on $monitor_1"
        hyprctl keyword wsbind $i,$monitor_1 > /dev/null
        hyprctl dispatch moveworkspacetomonitor $i $monitor_1 > /dev/null
    done
    hyprctl keyword workspace $monitor_1,1 > /dev/null
    for ((i = 4; i <= 7; i++)); do
        echo "Workspace $i on $monitor_2"
        hyprctl keyword wsbind $i,$monitor_2 > /dev/null
        hyprctl dispatch moveworkspacetomonitor $i $monitor_2 > /dev/null
    done
    hyprctl keyword workspace $monitor_2,4 > /dev/null
    for ((i = 8; i <= 10; i++)); do
        echo "Workspace $i on $monitor_3"
        hyprctl keyword wsbind $i,$monitor_3 > /dev/null
        hyprctl dispatch moveworkspacetomonitor $i $monitor_3 > /dev/null
    done
    hyprctl keyword workspace $monitor_3,8 > /dev/null
else  # more than 3 monitors...
    echo "Not supported"
fi
