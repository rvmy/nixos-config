#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/immutable-wallpapers"
mkdir -p "$WALLPAPER_DIR"

# Check if swww daemon is running
# if ! pgrep -x swww-daemon > /dev/null; then
#     notify-send "Starting swww daemon..."
#     swww-daemon &
#     sleep 2
# fi

# Get all wallpapers
wallpapers=$(fd -e jpg -e jpeg -e png -e webp . "$WALLPAPER_DIR" | sort)

# Debug: log wallpapers found
echo "Found wallpapers: $wallpapers" >> /tmp/wallpaper-debug.log

if [ -z "$wallpapers" ]; then
    notify-send "Wallpaper Switcher" "No wallpapers found in $WALLPAPER_DIR"
    exit 1
fi

chosen=$(echo "$wallpapers" | rofi -dmenu -i -p "Choose Wallpaper")

# Debug: log chosen wallpaper
echo "Chosen: $chosen" >> /tmp/wallpaper-debug.log

[ -z "$chosen" ] && exit 0

# Try to apply
swww img "$chosen" \
    --transition-type wipe \
    --transition-angle 30 \
    --transition-duration 2 \
    --transition-fps 60 2>&1 | tee -a /tmp/wallpaper-debug.log

notify-send "Wallpaper Changed" "Applied: $(basename "$chosen")"
