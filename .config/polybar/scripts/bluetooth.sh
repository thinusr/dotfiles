#!/bin/bash

# Gruvbox Colors
color_off="#cc241d"       # Red for OFF
color_on="#f8f8f2"        # Blue for ON
icon_off=""             # Red crossed-out Bluetooth icon for OFF
icon_on=""              # Blue Bluetooth icon for ON

# Get Bluetooth status
bluetooth_status=$(bluetoothctl show | grep "Powered" | awk '{print $2}')

if [[ "$bluetooth_status" == "yes" ]]; then
    # Bluetooth is ON
    connected_devices=$(bluetoothctl devices | while read -r line; do
        device_id=$(echo "$line" | awk '{print $2}')
        device_info=$(bluetoothctl info "$device_id")
        if echo "$device_info" | grep -q "Connected: yes"; then
            echo 1
        fi
    done | wc -l)

    if [ "$connected_devices" -eq 0 ]; then
        echo "%{F$color_on}$icon_on No Devices%{F-}"  # ON with no devices
    else
        echo "%{F$color_on}$icon_on $connected_devices%{F-}"  # ON with connected devices
    fi
else
    # Bluetooth is OFF
    echo "%{F$color_off}$icon_off OFF%{F-}"
fi