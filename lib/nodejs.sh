#!/usr/bin/env bash

if type ndenv > /dev/null; then
    export PATH="$HOME/.ndenv/bin:$PATH"
    eval "$(ndenv init -)"
fi
