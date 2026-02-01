#!/bin/zsh

# tmux switch-client -t "$(tmux ls -F '#{session_last_attached} #S'| sort -rn  | sed '1d' | cut -d' ' -f2- | sed 's/^/ /' | fzf --tmux bottom,100%,60% --style=full --bind 'enter:become(echo {2})' --preview 'sesh preview {2}')"

tmux ls -F '#{session_last_attached} #S'| sort -rn  | sed '1d' | cut -d' ' -f2- | sed 's/^/ /' | fzf  --style=full --bind 'enter:become(echo {2})' | xargs tmux switch-client -t

# target="$(
#   tmux ls -F '#{session_last_attached} #S' \
#   | sort -rn \
#   | sed '1d' \
#   | cut -d' ' -f2- \
#   | sed 's/^/ /' \
#   | fzf --tmux bottom,100%,60% \
#         --style=full \
#         --preview 'sesh preview {2}' \
#         --bind 'enter:become(echo {2})'
# )"
#
# [ -n "$target" ] && tmux switch-client -t "$target"


# target=$(tmux ls -F '#{session_last_attached} #S' | sort -rn | sed '1d' | cut -d' ' -f2- | sed 's/^/ /' | fzf --tmux bottom,100%,60% --style=full --bind 'enter:become(echo {2})' --preview 'sesh preview {2}') && [ -n "$target" ] && tmux switch-client -t "$target" exit 0
