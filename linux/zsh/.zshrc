# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="bira"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-vi-mode fzf fzf-tab sdk ssh pass zsh-autosuggestions zsh-syntax-highlighting)


#zsh completion
# Aktifkan Generic Completion untuk perintah dengan flag -h / --help
fpath=(~/.zsh/completions $fpath)
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

source $ZSH/oh-my-zsh.sh
_safe_gnu_generic() {
  # Jalankan _gnu_generic tapi buang stderr (pesan error) ke /dev/null
  _gnu_generic "$@" 2>/dev/null
}

# Gunakan wrapper yang aman sebagai default
compdef _safe_gnu_generic -default-
# compdef _gnu_generic -default-

zstyle ':completion:*' menu select

# Tampilkan deskripsi untuk opsi (flags) dan perintah
zstyle ':completion:*' verbose yes

# Format tampilan deskripsi (tampilan grup)
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format '%F{purple}-- %d --%f'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
# Memisahkan grup antara perintah, file, dan opsi
zstyle ':completion:*' group-name ''


# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
export FZF_COMPLETION_TRIGGER=',,'
export DISABLE_AUTO_TITLE='true'
export XDG_CONFIG_HOME="$HOME/.config"
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export PATH="$HOME/.fzf/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export QT_SELECT=6
export EDITOR='nvim'
export PATH=$PATH:"~/.spicetify"
export MANPAGER="nvim +Man!"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm() {
  unset -f nvm node npm npx
  source "$NVM_DIR/nvm.sh"
  nvm "$@"
}

node() {
  unset -f nvm node npm npx
  source "$NVM_DIR/nvm.sh"
  node "$@"
}

npm() {
  unset -f nvm node npm npx
  source "$NVM_DIR/nvm.sh"
  npm "$@"
}

npx() {
  unset -f nvm node npm npx
  source "$NVM_DIR/nvm.sh"
  npx "$@"
}
export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$PATH:$ANDROID_HOME/emulator"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:/$HOME/Application/flutter-sdk/3.29.3/flutter/bin"

show_color() {
  perl -e 'foreach $a(@ARGV){print "\e[48:2::".join(":",unpack("C*",pack("H*",$a)))."m  \e[49m "};print "\n"' "$@"
}

# Ensure wl-clipboard is installed
# Setup buffer copy for zsh vi mode
function zvm_vi_yank() {
  zvm_yank
  printf %s "${CUTBUFFER}" | wl-copy -n
  zvm_exit_visual_mode
}

function sesh-sessions() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
    zle reset-prompt > /dev/null 2>&1 || true
    [[ -z "$session" ]] && return
    sesh connect $session
  }
}

zle     -N             sesh-sessions
bindkey -M emacs '\es' sesh-sessions
bindkey -M vicmd '\es' sesh-sessions
bindkey -M viins '\es' sesh-sessions

# env local
if [ -f "$HOME/.env.local" ]; then
    source "$HOME/.env.local"
fi

alias seeapp='ls /usr/share/applications/*.desktop'
alias seeappflatpak='flatpak list --app --columns=application'
alias aichat='sh -c "XAPP_FORCE_GTKWINDOW_ICON=artificial_intelligence firefox -no-remote -P \"ai-chat\" --name Ai-Chat" > /dev/null 2>&1 &'
alias ytmusic='sh -c "XAPP_FORCE_GTKWINDOW_ICON=yt_music firefox -no-remote -P \"youtube-music\" --name Youtube-Music" > /dev/null 2>&1 &'

export PATH=$PATH:/home/chirikualii/.spicetify

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
