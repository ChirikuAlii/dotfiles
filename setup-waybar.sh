#!bin/bash

### ABOUT SYSTEM ###
chmod +x $XDG_CONFIG_HOME/waybar/fastfetch.sh

### WAYBAR-NIRI-TITLE ###
SOURCE_DIR="$XDG_CONFIG_HOME/waybar/modules-src/waybar-niri-title.go"
TARGET_BIN="$HOME/.local/bin/waybar-niri-title"
go build -C $XDG_CONFIG_HOME/waybar/modules-src -o "$TARGET_BIN"

if [ $? -eq 0 ]; then
    echo "Success! Binary installed to $TARGET_BIN"
else
    echo "Build failed!"
fi

chmod +x $TARGET_BIN
### WAYBAR-NIRI-TITLE ###
