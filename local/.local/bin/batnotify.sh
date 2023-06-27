#!/bin/bash
export DISPLAY=:0

battery_level=`acpi -b | grep -P -o '[0-9]+(?=%)'`
if [ $battery_level -le 10 ]
then
    DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus" notify-send -u critical "Battery low" "Battery level is ${battery_level}%!"
else if [ $battery_level -le 20 ]
then
    DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus" notify-send -u normal "Battery low" "Battery level is ${battery_level}%!"
fi
fi

exit 0
