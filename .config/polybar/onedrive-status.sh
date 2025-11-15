#!/bin/bash

# Path to OneDrive DB
DB="$HOME/.config/onedrive/items.sqlite3"

# Check if OneDrive monitor is running
if pgrep -x "onedrive" >/dev/null; then
    STATUS="Monitoring"
else
    STATUS="Stopped"
fi

# Check if OneDrive is actively syncing (DB modified in last 10 sec)
if [ -f "$DB" ]; then
    if test $(find "$DB" -mmin -0.166 -print); then
        STATUS="Syncing"
    fi
fi

# Color codes for Polybar
COLOR_STOPPED="%{F#BF616A}"   # red
COLOR_MONITOR="%{F#A3BE8C}"   # green
COLOR_SYNC="%{F#EBCB8B}"      # yellow
COLOR_RESET="%{F-}"

case $STATUS in
    "Stopped")
        echo "${COLOR_STOPPED}  ${COLOR_RESET}"
        ;;
    "Monitoring")
        echo "${COLOR_MONITOR}  ${COLOR_RESET}"
        ;;
    "Syncing")
        echo "${COLOR_SYNC}  ${COLOR_RESET}"
        ;;
esac

