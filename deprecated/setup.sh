#!/bin/zsh

set e
export DOT="$HOME/1.Code/2.Areas/dotfiles"
cd "$DOT" || exit 1


# daftar folder yang di-skip
SKIP_PACKAGES=(
  .git
  ghostty-mac
  ghostty-linux
  icons
  themes
  scripts
  linux
  zsh
)

should_skip() {
  local pkg="$1"
  for skip in "${SKIP_PACKAGES[@]}"; do
    [[ "$pkg" == "$skip" ]] && return 0
  done
  return 1
}

for pkg in */; do
  pkg="${pkg%/}" # hapus trailing slash

  # skip kalau bukan directory
  [[ ! -d "$pkg" ]] && continue

  if should_skip "$pkg"; then
    echo "⏭  skip: $pkg"
    continue
  fi

  echo "📦 stow: $pkg"
  stow -t "$HOME" "$pkg"
done


echo "✅ setup done"
sh "$DOT/setup-ghostty.sh"

stow -d "$DOT/icons" -t "$HOME" gruvbox-plus-icon-pack
echo "✅ setup gruvbox-plus-icon-pack done"

stow -d "$DOT/themes/kvantum" -t "$HOME" gruvbox
echo "✅ setup gruvbox-kvantum done"

stow -d "$DOT/scripts/tmux-auto-save" -t  $HOME bin
echo "✅ setup tmux-auto-save done"

stow -d "$DOT/scripts" -t $HOME tmux-save-session 
echo "✅ setup tmux-save-session done"

stow -d "$DOT/scripts" -t $HOME tmux-sessionizer 
echo "✅ setup tmux-sessionizer done"



stow -d "$DOT/linux" -t $HOME  wallpapers
stow -d "$DOT/linux/scripts" -t $HOME swaybg-slideshow
chmod +x $HOME/.local/bin/wallpaper.sh
echo "✅ setup wallpaper.sh done"

