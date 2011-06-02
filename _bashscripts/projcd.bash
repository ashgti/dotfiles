#!/usr/bin/env bash

function projcd {
    if [ -z $1 ]; then
      cd "${HOME}/Projects"
      return 0
    fi
    local dest=$(find "${HOME}/Projects" -type d -maxdepth 2 -name "$1" -print0)
    eval "cd $dest"
    return 0
}

