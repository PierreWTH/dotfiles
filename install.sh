#!/usr/bin/env bash

set -e
set -u

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

## Helpers ##

log() {
    echo -e "\033[1;34m[SETUP]\033[0m $1"
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Symlink $1 to $2, backing up $2 if it is a real file/directory
link() {
    local src="$1" dest="$2"
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        log "Backing up $dest to $dest.backup"
        mv "$dest" "$dest.backup"
    fi
    ln -sfn "$src" "$dest"
}

## Symlinks ##

create_symlinks() {
    log "Creating symlinks for config files..."
    link "$DOTFILES/.config" "$HOME/.config"
    link "$DOTFILES/.zshrc" "$HOME/.zshrc"
    link "$DOTFILES/.zprofile" "$HOME/.zprofile"
}

## Homebrew ##

# No other config needed : aerospace, btop, fastfetch, kitty, nvim, yazi
install_homebrew() {
    if command_exists brew; then
        log "Homebrew already installed"
    else
        log "Installing homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    # Make brew available in this script (not in PATH right after install)
    eval "$(/opt/homebrew/bin/brew shellenv)"
}

install_packages() {
    log "Installing packages"
    brew bundle --file="$DOTFILES/Brewfile"

    # nvm needs its directory to exist
    mkdir -p "$HOME/.nvm"

    # Start sketchybar at startup
    brew services start sketchybar
}

## Oh my zsh ##

export ZSH="$DOTFILES/.config/zsh/.oh-my-zsh"

install_oh_my_zsh() {
    if [ -d "$ZSH" ]; then
        log "Oh My Zsh already installed"
    else
        log "Installing Oh My Zsh..."
        RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c \
            "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
}

## Powerlevel10k ##

# No need to configure because .p10k.zsh is already in place
install_p10k() {
    local theme_dir="$ZSH/custom/themes/powerlevel10k"

    if [ -d "$theme_dir" ]; then
        log "Powerlevel10k already installed"
    else
        log "Installing Powerlevel10k..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$theme_dir"
    fi
}

## Main script ##

main() {
    create_symlinks
    install_homebrew
    install_packages
    install_oh_my_zsh
    install_p10k

    log "Setup complete! Open a new terminal to load the config."
}

main
