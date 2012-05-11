##########################
## oh-my-zsh settings
##########################

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Random until I create my own
ZSH_THEME="random"

# I have no trouble using the correct case in completion
# So it showing me extra stuff is annoying
CASE_SENSITIVE="true"


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git perl svn github cpanm)

source $ZSH/oh-my-zsh.sh

# Include perl stuff
source ~/.env/perl.sh
