#!/usr/bin/env bash

set -e
set -u

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

## Helpers ##

log() {
    echo -e "\033[1;34m[SETUP]\033[0m $1"
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

    # AeroSpace refuses to start if ~/.aerospace.toml and ~/.config/aerospace both exist
    if [ -f "$HOME/.aerospace.toml" ]; then
        log "Backing up ~/.aerospace.toml to ~/.aerospace.toml.backup"
        mv "$HOME/.aerospace.toml" "$HOME/.aerospace.toml.backup"
    fi
}

## Homebrew ##

# No other config needed : aerospace, btop, fastfetch, nvim, p10k, yazi
install_homebrew() {
    # Check the binary directly: brew may be installed but not yet in PATH
    if [ -x /opt/homebrew/bin/brew ]; then
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
}

## Main script ##

main() {
    create_symlinks
    install_homebrew
    install_packages

    # Load the repo config if AeroSpace is already running
    aerospace reload-config 2>/dev/null || true

    log "Setup complete! Open a new terminal to load the config."
}

main
