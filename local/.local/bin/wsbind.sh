#!/bin/bash
#
#

monitor_count=$(hyprctl monitors -j | jq '. | length')

echo "Configuring for $monitor_count monitors"
if [[ "$monitor_count" == 1 ]]; then
    monitor_1=$(hyprctl monitors -j | jq -r '.[0].name')
    for ((i = 1; i <= 9; i++)); do
        echo "Workspace $i on $monitor_1"
        hyprctl keyword wsbind $i,$monitor_1 > /dev/null
        hyprctl dispatch moveworkspacetomonitor $i $monitor_1 > /dev/null
    done
    hyprctl keyword workspace $monitor_1,1
    for ((i = 1; i <= 9; i++)); do
        hyprctl keyword bind SUPER,$i,exec,hyprsome workspace $i > /dev/null
        hyprctl keyword bind SUPERSHIFT,$i,exec,hyprsome move $i > /dev/null
    done
elif [[ "$monitor_count" == 2 ]]; then
    monitor_1=$(hyprctl monitors -j | jq -r '.[0].name')
    monitor_2=$(hyprctl monitors -j | jq -r '.[1].name')
    for ((i = 11; i <= 15; i++)); do
        echo "Workspace $i on $monitor_2"
        hyprctl keyword wsbind $i,$monitor_2 > /dev/null
        hyprctl dispatch moveworkspacetomonitor $i $monitor_2 > /dev/null
    done
    hyprctl keyword workspace $monitor_2,11 > /dev/null
    for ((i = 1; i <= 5; i++)); do
        echo "Workspace $i on $monitor_1"
        hyprctl keyword wsbind $i,$monitor_1 > /dev/null
        hyprctl dispatch moveworkspacetomonitor $i $monitor_1 > /dev/null
    done
    hyprctl keyword workspace $monitor_1,1 > /dev/null
    for ((i = 1; i <= 5; i++)); do
        hyprctl keyword bind SUPER,$i,exec,hyprsome workspace $i > /dev/null
        hyprctl keyword bind SUPERSHIFT,$i,exec,hyprsome move $i > /dev/null
    done
fi
