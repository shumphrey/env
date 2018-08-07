###################################
## Funky git hook
##
## Tries to source a .zsh-hooks file whenever it cds into a directory

autoload -U add-zsh-hook
load-local-conf() {
    # check if a .zsh-hooks file exists for this directory.
    # If so, source it
    if [[ -f .zsh-hooks && -r .zsh-hooks ]]; then
        source .zsh-hooks
    fi
}
add-zsh-hook chpwd load-local-conf

