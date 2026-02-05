#!/bin/zsh

set e
export DOT="$HOME/1.Code/2.Areas/dotfiles"
cd "$DOT" || exit 1

# daftar folder yang di-skip
SKIP_PACKAGES=(
  .git
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
  stow -D -t "$HOME" "$pkg"
done



stow -D -t "$HOME" "ghostty-linux"
stow -D -t "$HOME" "ghostty-mac"
echo "unlink setup ghostty done"

stow -D -d "$DOT/icons" -t "$HOME" gruvbox-plus-icon-pack
echo "unlink setup gruvbox-plus-icon-pack done"

stow -D -d "$DOT/themes/kvantum" -t "$HOME" gruvbox
echo "unlink setup gruvbox-kvantum done"

stow -D -d "$DOT/scripts/tmux-auto-save" -t  $HOME bin
echo "unlink setup tmux-auto-save done"

stow -D -d "$DOT/scripts" -t $HOME tmux-save-session 
echo "unlink setup tmux-save-session done"

stow -D -d "$DOT/scripts" -t $HOME tmux-sessionizer 
echo "unlink setup tmux-sessionizer done"


stow -D -d "$DOT/linux" -t $HOME  wallpapers
stow -D -d "$DOT/linux/scripts" -t $HOME swaybg-slideshow
echo "unlink setup wallpaper.sh done"
