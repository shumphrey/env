##############################
## Solarized
##############################

source ~/.env/solarized.sh

##########################
## oh-my-zsh settings
##########################
DISABLE_AUTO_UPDATE="true"

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="meri"

# I have no trouble using the correct case in completion
# So it showing me extra stuff is annoying
CASE_SENSITIVE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git cpanm)

source $ZSH/oh-my-zsh.sh

unsetopt CORRECT_ALL;

## My own completions
fpath=(~/.env/zsh/completions $fpath)
autoload -U compinit
compinit

#############################
## Aliases
#############################

alias please="sudo"
alias ffs="sudo"
alias v="vim"

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

##############################
## git
##############################

unalias g # need to look into removing oh-my-zsh

# git default to status
function g {
    if [[ $# > 0 ]]; then
        git $@
    else
        git status
    fi
}

##############################
## tmux
##  corresponding completions in .env/zsh/completions/_tm
##############################
function tm {
    if [[ $# < 1 ]]; then
        echo "need tmux session name"
    else
        tmux attach -t "$1" || tmux new -s "$1"
    fi
}

##############################
## perl
##############################

# Include perl stuff
source ~/.env/perl.sh

##############################
## other
##############################

## theme needs 256 colours. Don't think I'll use one with less colours
export TERM='xterm-256color'

## up down search through completion history
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward
bindkey "${terminfo[kcuu1]}" history-beginning-search-backward
bindkey "${terminfo[kcud1]}" history-beginning-search-forward

export EDITOR=vim

export PAGER="less -r -X"
alias less="less -r -X"

## Why would I ever want to run perl without new features enabled
alias p="perl -E"
