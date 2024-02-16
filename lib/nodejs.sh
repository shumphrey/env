#!/usr/bin/env bash

if [[ -d $HOME/.nodenv ]]; then
    # export PATH="$HOME/.ndenv/bin:$PATH"
    eval "$(nodenv init -)"
fi
