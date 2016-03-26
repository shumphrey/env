# zsh theme requires 256 color enabled terminal
# i.e TERM=xterm-256color

setopt prompt_subst

REDF="%f%F{124}"
GREENF="%f%F{154}"

ZSH_THEME_GIT_PROMPT_PREFIX="%F{154}±|%f%F{124}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}✘%b%F{154}|%f%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %F{green}✔%F{154}|"

# ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
# ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
# ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
# ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
# ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
# ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭"

# Outputs if current branch is behind remote
function git_prompt_behind() {
  git_behind_count=$(git rev-list ..@{u} 2>/dev/null | wc -l)
  if [[ "$git_behind_count" != "0" ]]; then
    echo "%F{red}${git_behind_count}⬇"
  fi
}

# Outputs if current branch is ahead of remote
function git_prompt_ahead() {
  git_ahead_count=$(git rev-list @{u}.. 2>/dev/null | wc -l)
  if [[ "$git_ahead_count" != "0" ]]; then
    echo "%F{blue}${git_ahead_count}⬆"
  fi
}

## ~/my/path/relative/to/home
## user@host%                                                  (git info)
## % is # if root. Some colours
RPROMPT='$(git_prompt_info)$(git_prompt_ahead)$(git_prompt_behind) %f%{$reset_color%}'
PROMPT='%F{green}%~
%F{208}%n%f%{$fg[white]%}@%F{blue}%m%f%{$reset_color%}%#%b '


## Add crazy prompt character functions
## e.g., different character for git, svn, normal, other?
# TODO:
