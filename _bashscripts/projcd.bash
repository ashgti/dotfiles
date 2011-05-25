#!/usr/bin/env bash

function projcd {
    if [ -z $1 ]; then
      cd "${HOME}/Projects"
      return 0
    fi
    
    cd "$(find "${HOME}/Projects" -type d -maxdepth 2 -name $1)"
    return 0
}
