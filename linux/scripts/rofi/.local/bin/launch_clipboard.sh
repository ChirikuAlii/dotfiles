#!/bin/bash

# If an argument is passed, it means we selected an item to copy
if [[ -n "$1" ]]; then
    cliphist decode <<<"$1" | wl-copy
    exit
fi

# Generate the list for Rofi
# This gawk script looks for binary/image entries and creates thumbnails

	# rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 250px;}' \
# Run rofi with icons enabled
cliphist list | rofi -dmenu -theme-str 'window {width: 1000px;}' -i -show-icons -p "Clipboard" | cliphist decode | wl-copy
