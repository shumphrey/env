# stop venv from messing with my PS1
VIRTUAL_ENV_DISABLE_PROMPT=1

# still adds some time to startup
if command -v pyenv 1>/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  eval "$(pyenv init -)"
fi
