# zsh theme requires 256 color enabled terminal
# i.e TERM=xterm-256color

setopt prompt_subst

ZSH_THEME_GIT_PROMPT_PREFIX="%F{154}±|%f%F{124}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✘%b%F{154}|%f%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔%F{154}|"

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭"

## ~/my/path/relative/to/home
## user@host%                                                  (git info)
## % is # if root. Some colours
RPROMPT='$(git_prompt_info) %f%{$reset_color%}'
PROMPT='%F{green}%~
%F{208}%n%f%{$fg[white]%}@%F{blue}%m%f%{$reset_color%}%#%b '


## Add crazy prompt character functions
## e.g., different character for git, svn, normal, other?
# TODO:
