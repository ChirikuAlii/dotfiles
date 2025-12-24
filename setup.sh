export DOT="$HOME/1.Code/2.Areas/dotfiles"

ln -sf "$DOT/nvim" "$HOME/.config"
ln -sf "$DOT/tmux/.tmux.conf" "$HOME/.tmux.conf"
sh "$DOT/ghostty/setup-ghostty.sh"
