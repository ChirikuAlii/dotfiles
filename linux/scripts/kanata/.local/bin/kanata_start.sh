#!/bin/bash

KANATA_BIN=$(which kanata)

exec "$KANATA_BIN" --cfg "$HOME/.config/kanata/kanata.kbd" --no-wait 
