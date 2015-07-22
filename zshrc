##############################
## Include Files
##############################

source ~/.env/solarized.sh
source ~/.env/oh-my-zsh.sh
source ~/.env/perl.sh

## My own completions
fpath=(~/.env/zsh/completions $fpath)
autoload -U compinit
compinit
compdef '_dispatch git git' g

######################################
## Aliases + Functions + Key Bindings
######################################

alias please="sudo"
alias ffs="sudo"
alias v="vim"
alias less="less -r -X"

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# git default to status
# completion still works
function g {
    if [[ $# > 0 ]]; then
        git $@
    else
        git status
    fi
}

# tmux
#  corresponding completions in .env/zsh/completions/_tm
function tm {
    if [[ $# < 1 ]]; then
        echo "need tmux session name"
    else
        tmux attach -t "$1" || tmux new -s "$1"
    fi
}

## up down search through completion history
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward
bindkey "${terminfo[kcuu1]}" history-beginning-search-backward
bindkey "${terminfo[kcud1]}" history-beginning-search-forward

## theme needs 256 colours. Don't think I'll use one with less colours
export TERM='xterm-256color'
export EDITOR=vim
export PAGER="less -r -X"
