#!/bin/bash

# Gruvbox Colors
color_off="#cc241d"       # Red for OFF
color_on="#f8f8f2"        # Blue for ON
icon_off=""
icon_on=""

# --- 1. Kernel-level Bluetooth presence ---
# If /sys/class/bluetooth is empty, the kernel sees no adapters.
if [ ! -d /sys/class/bluetooth ] || [ -z "$(ls -A /sys/class/bluetooth 2>/dev/null)" ]; then
    echo "%{F$color_off}$icon_off OFF%{F-}"
    exit 0
fi

# --- 2. Check rfkill (hardware/software block) ---
rfkill_state=$(rfkill list bluetooth 2>/dev/null | grep -i "Soft blocked" | awk '{print $3}')
if [ "$rfkill_state" = "yes" ]; then
    echo "%{F$color_off}$icon_off BLOCKED%{F-}"
    exit 0
fi

# --- 3. BlueZ availability check ---
# If bluetoothctl can't see a controller, we still show ON (kernel says it's on)
controller=$(bluetoothctl list | wc -l)

if [ "$controller" -eq 0 ]; then
    # BlueZ is glitching but Bluetooth is actually ON
    echo "%{F$color_on}$icon_on ON%{F-}"
    exit 0
fi

# --- 4. Count connected devices (only if BlueZ is working) ---
connected_devices=$(bluetoothctl devices | while read -r line; do
    device_id=$(echo "$line" | awk '{print $2}')
    device_info=$(bluetoothctl info "$device_id" 2>/dev/null)
    if echo "$device_info" | grep -q "Connected: yes"; then
        echo 1
    fi
done | wc -l)

if [ "$connected_devices" -eq 0 ]; then
    echo "%{F$color_on}$icon_on No Devices%{F-}"
else
    echo "%{F$color_on}$icon_on $connected_devices%{F-}"
fi

