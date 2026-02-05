#!bin/bash


killall waybar
# GTK_DEBUG=interactive \
# waybar -c $XDG_CONFIG_HOME/waybar/config-bottom/config.jsonc & 
# GTK_DEBUG=interactive waybar \
#   -c $XDG_CONFIG_HOME/waybar/config-bottom/config.jsonc \
#   -s $XDG_CONFIG_HOME/waybar/config-bottom/style.css

# GTK_DEBUG=interactive \
waybar -c $XDG_CONFIG_HOME/waybar/config.jsonc 
