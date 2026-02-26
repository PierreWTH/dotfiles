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
   log "Installing packages" 
   brew bundle --file="./Brewfile"
}

## Oh my zsh ##

install_oh_my_zsh(){
    if [ -d "$HOME/.oh-my-zsh" ]; then
    log "Oh My Zsh already installed"
  else
    log "Installing Oh My Zsh..."
    RUNZSH=no CHSH=no sh -c \
      "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
}

## Powerlevel10k ##

install_p10k() {
  ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

  if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    log "Installing Powerlevel10k..."
    git clone --depth=1 \
      https://github.com/romkatv/powerlevel10k.git \
      "$ZSH_CUSTOM/themes/powerlevel10k"
  fi
}

configure_p10k(){
    log "Configuring p10k theme..."
}

