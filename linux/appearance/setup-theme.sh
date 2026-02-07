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
stow -v -R -t "$HOME" "$folder" 

# stow fonts
folder="fonts"
log "Stowing $folder..."
stow -v -R -t "$HOME" "$folder" 
cd "$DOTFILES"

# themes 
cd "$DOTFILES/appearance/themes/gruvbox-gtk-theme/themes"
chmod +x install.sh
sh install.sh -t all --tweaks soft float -l

# icons
cd "$DOTFILES/appearance/icons/gruvbox-plus-icon-pack/scripts"
log "Symlink Manual icons"
chmod +x folders-color-chooser
mkdir -p "$HOME/.local/share/icons"
ln -s "$DOTFILES/appearance/icons/gruvbox-plus-icon-pack/Gruvbox-Plus-Dark" "$HOME/.local/share/icons/Gruvbox-Plus-Dark"  
ln -s "$DOTFILES/appearance/icons/gruvbox-plus-icon-pack/Gruvbox-Plus-Light" "$HOME/.local/share/icons/Gruvbox-Plus-Light"  
sh folders-color-chooser -c blue


log "DONE ALL"


