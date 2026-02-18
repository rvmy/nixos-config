#!/usr/bin/env bash

# Directory to save screenshots
DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"

# Timestamp for filename
FILENAME="$DIR/Screenshot_$(date +%F_%H-%M-%S).png"

# Take screenshot
if [[ "$1" == "area" ]]; then
    # Area screenshot
    grim -g "$(slurp)" "$FILENAME"
else
    # Fullscreen screenshot
    grim "$FILENAME"
fi

# Check if screenshot was created successfully
if [[ ! -f "$FILENAME" ]]; then
    notify-send "Screenshot failed"
    exit 1
fi

# Send notification
notify-send "Screenshot saved" "$FILENAME"

# Play a sound
pw-play /home/rami/.config/waybar/screenshot.wav

# Copy screenshot to clipboard
cat "$FILENAME" | wl-copy
