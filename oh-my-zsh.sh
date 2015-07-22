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
plugins=(cpanm command-not-found npm)

source $ZSH/oh-my-zsh.sh

unsetopt CORRECT_ALL;



