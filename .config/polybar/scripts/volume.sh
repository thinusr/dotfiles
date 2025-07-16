#!/bin/bash

# Get current volume and mute status
vol_output=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
vol=$(echo "$vol_output" | awk '{printf "%.0f\n", $2 * 100}')
muted=$(echo "$vol_output" | grep -q MUTED && echo "yes" || echo "no")

# Choose icon and output
if [ "$muted" = "yes" ]; then
    icon="󰖁"
    echo "$icon Muted"
else
    if [ "$vol" -eq 0 ]; then
        icon="󰖁"
    elif [ "$vol" -le 33 ]; then
        icon="󰕿"
    elif [ "$vol" -le 66 ]; then
        icon="󰖀"
    else
        icon="󰕾"
    fi

    echo "$icon $vol%"
fi
