#!/bin/bash

DOTFILES="$HOME/1.Code/2.Areas/dotfiles/linux"
set -e

log() {
    echo -e "\n\033[1;34m===> $1 \033[0m"
}

cd $DOTFILES
cd "$DOTFILES/appearance"

# stow config kvantum , qt5ct qt6ct , xfce4
folder="config"
log "Stowing $folder..."
stow -D -v -t "$HOME" "$folder" 

# stow fonts
folder="fonts"
log "Stowing $folder..."
stow -D -v -t "$HOME" "$folder" 
cd "$DOTFILES"

# themes 
cd "$DOTFILES/appearance/themes/gruvbox-gtk-theme/themes"
chmod +x install.sh
sh install.sh -u -r 
cd "$DOTFILES"

# icons
cd "$DOTFILES/appearance/icons/gruvbox-plus-icon-pack/scripts"
rm "$HOME/.local/share/icons/Gruvbox-Plus-Dark"
rm "$HOME/.local/share/icons/Gruvbox-Plus-Light"
cd "$DOTFILES"


