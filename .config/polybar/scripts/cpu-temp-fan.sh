#!/bin/bash

# ----------- POLYBAR CPU STATUS SCRIPT -----------

# Get CPU package temperature
TEMP_C=$(sensors 2>/dev/null | awk '/Package id 0:/ {gsub("\\+|°C","",$4); print int($4)}')
TEMP="${TEMP_C:-N/A}°C"

# Get fan speed
FAN=$(sensors 2>/dev/null | awk '/thinkpad-isa-0000/,/^$/' | awk '/fan1:/ {print $2 " RPM"}')
FAN=${FAN:-"N/A"}

# Get current CPU frequency (from /proc/cpuinfo)
FREQ=$(awk -F: '/cpu MHz/ {print $2; exit}' /proc/cpuinfo | sed 's/^[ \t]*//')
if [[ -n "$FREQ" ]]; then
    # Convert MHz to GHz with two decimals
    FREQ=$(printf "%.2f GHz" "$(echo "$FREQ/1000" | bc -l)")
else
    FREQ="N/A"
fi

# Determine color based on temperature
if [[ "$TEMP_C" =~ ^[0-9]+$ ]]; then
    if [ "$TEMP_C" -ge 85 ]; then
        COLOR="#cc241d"  # red
    elif [ "$TEMP_C" -ge 70 ]; then
        COLOR="#fabd2f"  # orange
    else
        COLOR="#b8bb26"  # green
    fi
else
    COLOR="#b8bb26"      # default green if temp is missing
fi

# Output formatted string for Polybar
echo "%{F$COLOR} $TEMP  $FAN ⚡ $FREQ%{F-}"

