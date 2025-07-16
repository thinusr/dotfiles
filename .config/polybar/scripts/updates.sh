#!/bin/bash

# Default counts
updates_arch=0
updates_aur=0

# Get Pacman updates
if command -v checkupdates &>/dev/null; then
    updates_arch=$(checkupdates 2>/dev/null | wc -l)
fi

# Get AUR updates
if command -v yay &>/dev/null; then
    updates_aur=$(yay -Qum 2>/dev/null | wc -l)
fi

# Total updates
total_updates=$((updates_arch + updates_aur))

# Polybar formatting
if [ "$total_updates" -gt 0 ]; then
    echo "%{F#cc241d}AUR = $updates_aur / Arch = $updates_arch%{F-}"
else
    echo "AUR = $updates_aur / Arch = $updates_arch"
fi


