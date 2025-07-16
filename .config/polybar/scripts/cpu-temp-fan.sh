#!/bin/bash

# Get CPU package temperature
TEMP_C=$(sensors | awk '/Package id 0:/ {gsub("\\+|°C","",$4); print int($4)}')
TEMP="${TEMP_C}°C"

# Get fan speed
FAN=$(sensors | awk '/thinkpad-isa-0000/,/^$/' | awk '/fan1:/ {print $2 " RPM"}')

# Set fallback values
TEMP=${TEMP:-"N/A"}
FAN=${FAN:-"N/A"}

# Determine color based on temperature
if [ "$TEMP_C" -ge 85 ]; then
    COLOR="#cc241d"  # red
elif [ "$TEMP_C" -ge 70 ]; then
    COLOR="#fabd2f"  # orange
else
    COLOR="#b8bb26"  # green
fi

# Output with Polybar formatting
echo "%{F$COLOR} $TEMP  $FAN%{F-}"
