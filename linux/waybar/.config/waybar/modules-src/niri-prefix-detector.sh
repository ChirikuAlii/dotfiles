#!/bin/bash


while true; do
  niri_prefix=$(ps -eo command --no-headers | grep "niri_prefix.py" | head -n 1 | grep -v grep )
  if [[ -n "$niri_prefix" ]]; then
    echo "{\"text\": \"[ Niri Mode ]\", \"tooltip\": \"Workspace Mode Active\"}"
  else 
    echo "{\"text\": \"\", \"tooltip\": \"Workspace Mode Normal\"}"
  fi
  sleep 0.1

done

