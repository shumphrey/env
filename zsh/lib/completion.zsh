
fpath=(~/.env/zsh/completions $fpath)
# Use modern completion system
autoload -Uz compinit

setopt extendedglob
if [[ -n $HOME/.zcompdump(#qN.mh+96) ]]; then
    echo "Regenerating completions as ~/.zcompdump(#qN.mh+24) is older than 96 hours"
    compinit
else
    compinit -C
fi
setopt noextendedglob

setopt auto_menu
setopt complete_in_word
setopt always_to_end

zmodload -i zsh/complist

zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
        clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
        gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
        ldap lp mail mailman mailnull man messagebus  mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
        operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
        usbmux uucp vcsa wwwrun xfs '_*'

zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories


compdef '_dispatch git git' g
source ~/.env/zsh/completions/_git_extras

## emulate bash completions?
# autoload -U bashcompinit
# bashcompinit
# if type bash-complete > /dev/null; then
#     eval "$(bash-complete setup | grep -v perldoc)"
# fi

