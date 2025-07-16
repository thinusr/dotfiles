#!/usr/bin/env bash

# Kill any running Polybar instances
killall -q polybar

# Wait until they're all gone
while pgrep -u "$UID" -x polybar >/dev/null; do sleep 0.1; done

# Launch Polybar on each monitor
for MON in HDMI-2 eDP-1; do
  MONITOR=$MON polybar mainbar-i3 &
done

# Add bottom bars (one per monitor)
#MONITOR=eDP-1 polybar bottombar &
#MONITOR=HDMI-2 polybar bottombar &


