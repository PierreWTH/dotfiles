#!/usr/bin/env bash

set -e
set -u

## Helpers ##

log() {
    echo -e "\033[1;34m[SETUP]\033[0m $1"
}

command_exists() {
    command -v "$1" >/dev/null 2>1
}

## Homebrew ## 

install_homebrew(){
    if command_exists brew; then
        log("Homebrew already installed")
    else
        log("Installing homebrew...")
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
}   

install_packages(){
    
}