# zsh theme requires 256 color enabled terminal
# i.e TERM=xterm-256color

setopt prompt_subst

REDF="%f%F{124}"
GREENF="%f%F{154}"

ZSH_THEME_GIT_PROMPT_PREFIX="%F{154}±|%f%F{030}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%b%F{154}|"
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{009}✘"
ZSH_THEME_GIT_PROMPT_CLEAN=" %F{green}✔"
ZSH_THEME_GIT_PROMPT_STASH="%F{009}◎"

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

# Outputs current branch info in prompt format
function git_prompt_info() {
  local ref
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0

  # if we've got here, we're in a git repo
  local TEXT="$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}"
  local AHEAD=$(git_prompt_ahead)
  local BEHIND=$(git_prompt_behind)
  local STASH=$(git_stash_count)
  local DIRTY=$(parse_git_dirty)

  echo "$STASH$TEXT$DIRTY$AHEAD$BEHIND$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# Checks if working tree is dirty
function parse_git_dirty() {
  local STATUS=''
  local FLAGS
  FLAGS=('--porcelain')
  if [[ $POST_1_7_2_GIT -gt 0 ]]; then
    FLAGS+='--ignore-submodules=dirty'
  fi
  if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" == "true" ]]; then
    FLAGS+='--untracked-files=no'
  fi
  STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -n1)
  if [[ -n $STATUS ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

function git_stash_count() {
    local COUNT
    COUNT=$(git stash list 2>/dev/null | wc -l)
    if [[ $COUNT > 0 ]]; then
        echo "$ZSH_THEME_GIT_PROMPT_STASH$COUNT %F{154}|%F{$reset_color}"
    fi
}


## ~/my/path/relative/to/home
## user@host%                                                  (git info)
## % is # if root. Some colours
RPROMPT='$(git_prompt_info)'
PROMPT='%F{green}%~
%F{208}%n%f%{$fg[white]%}@%F{blue}%m%f%{$reset_color%}%#%b '
