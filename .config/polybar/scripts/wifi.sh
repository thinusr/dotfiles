#!/bin/bash

# Gruvbox Colors
color_off="#cc241d"       # Red for disconnected/off
color_on="#f8f8f2"        #Green for connected
icon_off=""             # Warning symbol for OFF
icon_on=""              # Wi-Fi icon for ON

# Get Wi-Fi status
wifi_status=$(nmcli -t -f WIFI g)
connected_ssid=$(nmcli -t -f ACTIVE,SSID dev wifi | awk -F: '$1=="yes" {print $2}')
signal_strength=$(nmcli -t -f SIGNAL dev wifi | head -n 1)

if [[ "$wifi_status" == "enabled" && -n "$connected_ssid" ]]; then
    # Wi-Fi is ON and connected
    echo "%{F$color_on}$icon_on $connected_ssid ($signal_strength%)%{F-}"
else
    # Wi-Fi is OFF or no connection
    echo "%{F$color_off}$icon_off No Wi-Fi%{F-}"
fi
