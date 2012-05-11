
# History options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend
shopt -s checkwinsize

export EDITOR=vim

GREEN='\e[0;32m'
BOLDGREEN='\e[1;32m'
RESET='\e[0m'
BOLDBLUE='\e[1;34m'
RED='\e[0;31m'

# enable color support
# Either import solarized.sh for awesomeness
# Or set up some defaults
if [ "$TERM" = "xterm-256color" ]; then
    source ~/.env/solarized.sh
elif [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Set terminal prompt
# TODO: Import work PS1 here
PS1="${debian_chroot:+($debian_chroot)}${GREEN}\u${RESET}@${RED}\h${RESET}:${BOLDBLUE}\w${RESET}\$ "

# some more ls aliases
alias ls='ls --color=auto'
alias ll='ls -alF --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Perl env stuff
source ~/.env/perl.sh

alias si='screen -dr Irssi'

