# stop venv from messing with my PS1
VIRTUAL_ENV_DISABLE_PROMPT=1

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
