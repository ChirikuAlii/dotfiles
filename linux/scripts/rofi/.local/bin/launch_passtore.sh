#!/bin/bash
cd "$HOME/.password-store"
pass -c $(fd | cut -d "." -f 1 | grep -v "/$"| rofi -dmenu -p " Password")
