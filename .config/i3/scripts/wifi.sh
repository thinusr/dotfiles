#!/bin/bash

# Gruvbox Colors
color_off="#fb4934"       # Red for disconnected/off
color_on="#5294e2"        # Blue for connected
icon_off=""             # Warning symbol for OFF
icon_on=""              # Wi-Fi icon for ON

# Get Wi-Fi status
wifi_status=$(nmcli -t -f WIFI g)
connected_ssid=$(nmcli -t -f ACTIVE,SSID dev wifi | awk -F: '$1=="yes" {print $2}')

if [[ "$wifi_status" == "enabled" && -n "$connected_ssid" ]]; then
    # Wi-Fi is ON and connected
    echo "%{F$color_on}$icon_on $connected_ssid%{F-}"
else
    # Wi-Fi is OFF or no connection
    echo "%{F$color_off}$icon_off No Wi-Fi%{F-}"
fi
