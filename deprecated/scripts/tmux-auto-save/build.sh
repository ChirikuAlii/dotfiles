#!/bin/zsh
PROJECT_ROOT=$PWD
APP_NAME="tmux-auto-save"
SRC_DIR="$PROJECT_ROOT/src"

BIN_DIR="$PROJECT_ROOT/bin/.local/bin"
OUTPUT_PATH="$BIN_DIR/$APP_NAME"

go build -modfile "go.mod" -ldflags="-s -w" -o "$OUTPUT_PATH" "$SRC_DIR"

if [[ $? -eq 0 ]]; then
  echo "build success"
else 
  echo "build failed"
  return 1
fi
