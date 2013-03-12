##########################
## oh-my-zsh settings
##########################

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Random until I create my own
#ZSH_THEME="meri"
#ZSH_THEME="random"

# I have no trouble using the correct case in completion
# So it showing me extra stuff is annoying
CASE_SENSITIVE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git perl svn github cpanm)

source $ZSH/oh-my-zsh.sh

#############################
## Aliases
#############################

alias please="sudo"

##############################
## git
##############################

alias gpo="git push origin"
alias d="git difftool"
unalias g # what sets this?

# git default to status
function g {
    if [[ $# > 0 ]]; then
        git $@
    else
        git status --short --branch
    fi
}

##############################
## perl
##############################

# Include perl stuff
source ~/.env/perl.sh
