#!/usr/bin/env bash

if [[ -d $HOME/.ndenv ]]; then
    export PATH="$HOME/.ndenv/bin:$PATH"
    eval "$(ndenv init -)"
fi
