#!/bin/bash

enable="Enable Kanata"
disable="Disable Kanata"
result=$(echo -e "$enable\n$disable" | rofi -dmenu -p "Kanata")

if [[ $result == $enable  ]]; then
  enable_kanata=$(systemctl --user enable --now kanata.service)
elif [[ $result == $disable ]]; then
  disable_kanata=$(systemctl --user disable --now kanata.service)
else
  exit 0
fi
