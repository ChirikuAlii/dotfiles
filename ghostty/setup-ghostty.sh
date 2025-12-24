
mkdir -p "$HOME/.config/ghostty"

if [[ "$OSTYPE" == "darwin"* ]]; then
  ln -sf "$DOT/ghostty/config.mac" "$HOME/.config/ghostty/config"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  ln -sf "$DOT/ghostty/config.linux" "$HOME/.config/ghostty/config"
fi

ln -sf "$DOT/ghostty/shaders" "$HOME/.config/ghostty"
