#!/bin/bash


DOTFILES="$HOME/1.Code/2.Areas/dotfiles"


# echo "checking bw-cli"
# if command -v bw status &> /dev/null; then
#   echo "bw-cli sudah terinstall"
# else 
#   echo "bw-cli belum terinstall"
# fi
#
# check_session=$(bw status | jq -r ."status")
# if [[ $check_session == "unlocked" ]]; then
#   echo "bw session still active"
# else 
  BW_SESSION=$(bw unlock --raw)
  echo "move BW_SESSION to '$HOME/.env.local' "
  echo "export BW_SESSION=$BW_SESSION" > $HOME/.env.local
  echo "source zsh"
  source "$HOME/.zshrc"
  echo "Selesai setup sesi bitwarden"
# fi

# echo "take notes ssh-config"
# ssh_notes=$(bw get notes ssh-config)
# echo "move notes to dotfiles"
# mkdir -p $DOTFILES/ssh/.ssh
# ssh_notes > $DOTFILES/ssh/.ssh/config
#
# cd $DOTFILES
# stow -v -R -t "$HOME" "ssh"
# echo "stow ssh config dotfiles ke home"


## login 
## check session
## setup BW_SESSION to .env.local
## ssh-config notes 
## setup ssh-key notes to folder ssh 



# hsilnya di pindah ke 
#  $DOTFILES/ssh/.ssh/config
# status unlocked
# status locked
# status "unauthenticated"

# jika unclocked lanjut
# else jika locked atau unauthenticated
# lakukan bw unclock --raw ambil outputnya 
# masukkan di variabel BW_SESSSION 
# echo "export BW_SESSION=$BW_SESSSION" > $HOME/.env.local
  echo "source zsh"
  source "$HOME/.zshrc"
  echo "Selesai Setup SSH Config"




# Hasil=$(bw login)

# echo "$SESSION"
# echo "BW_SESSION=$(bw unlock --raw)" > .env.local
# jalankan bw nya kalau ga ada error kalau ada lanjut
# login
# dapat session key nya di taruh di env.local
# ambil note ssh-config lewat bw-cli 
# pindahkan taruh di folder ssh/.ssh/config 
# lakukan stow seperti script install-dotfiles-config

