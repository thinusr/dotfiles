#!/bin/bash

# Paths
ICON_PATH_VOLUME="$HOME/.icons/Gruvbox-Dark/panel/16"
ICON_PATH_BRIGHTNESS="$HOME/.icons/Gruvbox-Dark/status/symbolic"

get_volume_icon() {
    vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}')
    if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED; then
        echo "$ICON_PATH_VOLUME/audio-volume-muted.svg"
    elif (( $(echo "$vol < 0.3" | bc -l) )); then
        echo "$ICON_PATH_VOLUME/audio-volume-low.svg"
    elif (( $(echo "$vol < 0.7" | bc -l) )); then
        echo "$ICON_PATH_VOLUME/audio-volume-medium.svg"
    else
        echo "$ICON_PATH_VOLUME/audio-volume-high.svg"
    fi
}

get_brightness_icon() {
    level=$(brightnessctl get)
    max=$(brightnessctl max)
    percent=$(( level * 100 / max ))

    if (( percent == 0 )); then
        echo "$ICON_PATH_BRIGHTNESS/display-brightness-off-symbolic.svg"
    elif (( percent < 30 )); then
        echo "$ICON_PATH_BRIGHTNESS/display-brightness-low-symbolic.svg"
    elif (( percent < 70 )); then
        echo "$ICON_PATH_BRIGHTNESS/display-brightness-medium-symbolic.svg"
    else
        echo "$ICON_PATH_BRIGHTNESS/display-brightness-high-symbolic.svg"
    fi
}

send_notification() {
    icon="$1"
    title="$2"
    value="$3"  # If numeric percent, else string
    # If numeric, show slider, else just text
    if [[ "$value" =~ ^[0-9]+$ ]]; then
        dunstify -a "system" -r 91190 -u low -i "$icon" "$title" "${value}%" -h int:value:"$value"
    else
        dunstify -a "system" -r 91190 -u low -i "$icon" "$title" "$value"
    fi
}

case "$1" in
    volume_up)
        wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+
        vol_raw=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}')
        vol=$(printf "%.0f" "$(echo "$vol_raw * 100" | bc -l)")
        icon=$(get_volume_icon)
        send_notification "$icon" "Volume ↑" "$vol"
        ;;
    volume_down)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        vol_raw=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}')
        vol=$(printf "%.0f" "$(echo "$vol_raw * 100" | bc -l)")
        icon=$(get_volume_icon)
        send_notification "$icon" "Volume ↓" "$vol"
        ;;
    volume_mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED; then
            icon="$ICON_PATH_VOLUME/audio-volume-muted.svg"
            send_notification "$icon" "Volume" "Muted"
        else
            vol_raw=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}')
            vol=$(printf "%.0f" "$(echo "$vol_raw * 100" | bc -l)")
            icon=$(get_volume_icon)
            send_notification "$icon" "Volume" "$vol"
        fi
        ;;
    brightness_up)
        level=$(brightnessctl set +10% | grep -oP '\(\K[0-9]+(?=%\))')
        icon=$(get_brightness_icon)
        send_notification "$icon" "Brightness ↑" "$level"
        ;;
    brightness_down)
        level=$(brightnessctl set 10%- | grep -oP '\(\K[0-9]+(?=%\))')
        icon=$(get_brightness_icon)
        send_notification "$icon" "Brightness ↓" "$level"
        ;;
esac

