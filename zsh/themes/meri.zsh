# vim: set ts=2 sw=2 et:
# zsh theme requires 256 color enabled terminal
# i.e TERM=xterm-256color

setopt prompt_subst

# with prompt_subst on
# %F - start using foreground color
# %f - stop using foreground color
# can use $reset_color also

local REDF="%f%F{124}"
local GREENF="%f%F{154}"
local CYANF="%f%F{030}"
local ORANGEF="%f%F{009}"
local BLUEF="%f%F{blue}"

local GREEN_DIV="$GREENF|$reset_color"
local GIT_STASH_SYMBOL="◎"
local GIT_BEHIND_SYMBOL="⬇"
local GIT_AHEAD_SYMBOL="⬆"
local JOB_COUNT_SYMBOL="⚒"

# Outputs if there are background jobs in the terminal
function job_count() {
  if [ -n "$(jobs -p)" ]; then
    echo "$REDF$(jobs -p| grep -v ".*pwd now.*" | wc -l)$JOB_COUNT_SYMBOL$reset_color";
  fi
}

# Outputs if I have git stashes
function git_stash_count() {
  local COUNT=$(git stash list 2>/dev/null | wc -l)
  if [[ $COUNT > 0 ]]; then
    echo "$ORANGEF$COUNT$GIT_STASH_SYMBOL"
  fi
}

# Outputs if current branch is behind remote
function git_prompt_behind() {
  git_behind_count=$(git rev-list ..@{u} 2>/dev/null | wc -l)
  if [[ "$git_behind_count" != "0" ]]; then
    echo "$REDF${git_behind_count}$GIT_BEHIND_SYMBOL"
  fi
}

# Outputs if current branch is ahead of remote
function git_prompt_ahead() {
  git_ahead_count=$(git rev-list @{u}.. 2>/dev/null | wc -l)
  if [[ "$git_ahead_count" != "0" ]]; then
    echo "$BLUEF${git_ahead_count}$GIT_AHEAD_SYMBOL"
  fi
}

# Outputs current git info in prompt format
function my_git_info() {
  local ref
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0

  # if we've got here, we're in a git repo
  local TEXT="$CYANF${ref#refs/heads/}"
  local AHEAD="$(git_prompt_ahead)"
  local BEHIND="$(git_prompt_behind)"

  echo -n "$GREEN_DIV$TEXT$AHEAD$BEHIND$GREEN_DIV"
}

## ~/my/path/relative/to/home
## user@host%                                                  (git info)
## % is # if root. Some colours
RPROMPT='$(job_count) $(git_stash_count)$(my_git_info)'
PROMPT='%F{green}%~
%F{208}%n%f%{$fg[white]%}@%F{blue}%m%f%{$reset_color%}%#%b '
