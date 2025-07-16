#!/bin/bash

# Check if Dropbox is running
if pgrep -x dropbox >/dev/null; then
    echo "  %{F#8ec07c}%{F-}"  # Font Awesome tick (U+F00C)
else
    echo "  %{F#cc241d}%{F-}"   # Font Awesome cross (U+F00D)
fi

