#!/usr/bin/env bash

WALLDIR="$HOME/pictures/wallpapers"

find "$WALLDIR" -type f \
  \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) \
  | sort
