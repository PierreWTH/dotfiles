#!/usr/bin/env bash

set -e
set -u

## Helpers ##

log() {
    echo -e "\033[1;34m[SETUP]\033[0m $1"
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

## Homebrew ## 

# No other config needed : aerospace, btop, fastfetch, kitty, raycast, yazi
install_homebrew(){
    if command_exists brew; then
        log "Homebrew already installed"
    else
        log "Installing homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
}   

install_packages(){
    if [ ! -f "./Brewfile" ]; then
        log "Brewfile not found"
        exit 1
    fi

   log "Installing packages" 
   brew bundle --file="./Brewfile"

   # Start sketchybar at startup
   brew services start sketchybar
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

# No need to configure because .p10k.zsh is already in place 
install_p10k() {
  ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

  if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    log "Installing Powerlevel10k..."
    git clone --depth=1 \
      https://github.com/romkatv/powerlevel10k.git \
      "$ZSH_CUSTOM/themes/powerlevel10k"
  fi
}

## Lazyvim ##

# All requirements are already installed by brew
install_lazyvim() {
    if [ -d "$HOME/.config/nvim" ]; then
        log "LazyVim already installed"
    else
        log "Installing LazyVim..."
        git clone https://github.com/LazyVim/starter ~/.config/nvim
    fi
}

## Symbliks ##
create_symlinks() {
    log "Creating symlinks for config files..."

    DOTFILES_CONFIG="$HOME/.dotfiles/.config"
    TARGET_CONFIG="$HOME/.config"

    # Backup existing config if it exists and is not already a symlink
    if [ -d "$TARGET_CONFIG" ] && [ ! -L "$TARGET_CONFIG" ]; then
        log "Backing up existing ~/.config to ~/.config.backup"
        mv "$TARGET_CONFIG" "$HOME/.config.backup"
    fi

    ln -sfn "$DOTFILES_CONFIG" "$TARGET_CONFIG"
    ln -sfn "$(pwd)/.zshrc" "$HOME/.zshrc"

## Main script ##
main() {
    install_homebrew
    install_packages
    install_oh_my_zsh
    install_p10k
    install_lazyvim
    create_symlinks

    log "Setup complete!."
}

main