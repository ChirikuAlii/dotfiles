#!/bin/zsh

 set -e
if [[ "$OSTYPE" == "darwin"* ]]; then
  stow -t "$HOME""ghostty-mac"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  stow -t "$HOME" "ghostty-linux"
fi

echo "✅ setup ghostty done"

