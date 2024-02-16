# GIT heart FZF
# -------------

# Helpers
is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
  fzf-tmux --height 50% --min-height 20 --border --bind ctrl-/:toggle-preview "$@"
}

#--------------
# Git functions
#--------------

# show diffs for modified files
_gf() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1})' |
  cut -c4- | sed 's/.* -> //'
}

# list branches
_gb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-down --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1)' |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

# list tags
_gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {}'
}

# just a git log
_gh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always' |
  grep -o "[a-f0-9]\{7,\}"
}

# remotes and their main git log
_gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-down --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1}' |
  cut -d$'\t' -f1
}

# git stashes and show what they are
_gs() {
  is_in_git_repo || return
  git stash list | fzf-down --reverse -d: --preview 'git show --color=always {1}' |
  cut -d: -f1
}

# --------------
# zsh bindings
# --------------

# remove any binding of ctrl-g as this tends to break with tmux/zsh
# tmux forces us to send ctrl-b-ctrl-b but this doesn't work when ctrl-g is bound
bindkey -r "^g"
bindkey -r "^[^G"

join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

# Create bindings
# tmux means we have to do ^g^b^b for branch
bind-git-helper() {
  local c
  for c in $@; do
    eval "fzf-g$c-widget() { local result=\$(_g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    eval "bindkey '^g^$c' fzf-g$c-widget"
  done
}
# bind-git-helper f b t r h s
#
# can't do ctrl-s in a terminal...
# ctrl-b requires a double ctrl-b ctrl-b in tmux
bind-git-helper f b t r h
unset -f bind-git-helper
