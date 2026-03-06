#!/bin/bash
wl-copy $({ 
  awk '/^Host / {for (i=2; i<=NF; i++) if ($i !~ /[*?]/) print $i}' ~/.ssh/config; 
} | sort -u | grep -v "|" | rofi -dmenu -p " SSH")
