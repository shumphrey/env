# vim: set ts=2 sw=2 et:
# zsh theme requires 256 color enabled terminal
# i.e TERM=xterm-256color

setopt prompt_subst

local REDF="%f%F{124}"
local GREENF="%f%F{154}"

local ZSH_THEME_GIT_PROMPT_PREFIX="%F{154}|%f%F{030}"
local ZSH_THEME_GIT_PROMPT_SUFFIX="%b%F{154}|"
local ZSH_THEME_GIT_PROMPT_STASH="%F{009}◎"

# Outputs if there are background jobs in the terminal
function job_count() {
  if [ -n "$(jobs -p)" ]; then
    echo "$REDF$(jobs -p| grep -v ".*pwd now.*" | wc -l)⚒ $reset_color";
  fi
}

# Outputs if I have git stashes
function git_stash_count() {
  local COUNT=$(git stash list 2>/dev/null | wc -l)
  if [[ $COUNT > 0 ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_STASH$COUNT %F{154}|%F{$reset_color}"
  fi
}

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

# Outputs current git info in prompt format
function my_git_info() {
  local ref
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0

  # if we've got here, we're in a git repo
  local TEXT="$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}"
  local AHEAD="$(git_prompt_ahead)"
  local BEHIND="$(git_prompt_behind)"

  echo -n "$TEXT$AHEAD$BEHIND$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

## ~/my/path/relative/to/home
## user@host%                                                  (git info)
## % is # if root. Some colours
RPROMPT='$(job_count)$(git_stash_count)$(my_git_info)'
PROMPT='%F{green}%~
%F{208}%n%f%{$fg[white]%}@%F{blue}%m%f%{$reset_color%}%#%b '
