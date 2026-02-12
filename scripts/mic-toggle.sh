#!/usr/bin/env bash

DEVICE=@DEFAULT_AUDIO_SOURCE@
SOUNDS="$HOME/.config/sounds"

wpctl set-mute "$DEVICE" toggle

if wpctl get-volume "$DEVICE" | grep -q "\[MUTED\]"; then
  notify-send "󰍭 Microphone" "Muted"
  pw-play --volume 1.0 "$SOUNDS/mic-mute.wav" >/dev/null 2>&1 &
else
  notify-send " Microphone" "Unmuted"
  pw-play --volume 1.0 "$SOUNDS/mic-unmute.wav" >/dev/null 2>&1 &
fi
