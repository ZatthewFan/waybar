#!/bin/bash

status=$(bluetoothctl show | grep "Powered: yes")
device=$(bluetoothctl info | grep "Name:" | awk '{print $2}')

if [[ -n "$status" ]]; then
    if [[ -n "$device" ]]; then
        echo " $device"
    else
        echo " On"
    fi
else
    echo " Off"
fi
