
#!/bin/bash
DOTFILES="$HOME/1.Code/2.Areas/dotfiles/linux/btop"
echo "$PWD"

cd "$DOTFILES/../scripts"
folder="swaybg-slideshow"
# log "Stowing $folder..."
stow -v -R -t "$HOME/1.Code" "$folder" 
cd "$DOTFILES"
