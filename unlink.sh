#!/bin/zsh
set -e


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


