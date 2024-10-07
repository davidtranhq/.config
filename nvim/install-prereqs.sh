#!/bin/bash

command_exists() {
	command -v "$1" >/dev/null 2>&1
}

install_if_not_exists() {
    local cmd_name=$1
    local install_cmd=$2

    if ! command_exists "$cmd_name"; then
        echo "Installing $cmd_name..."
        eval "$install_cmd"
    else
        echo "$cmd_name is already installed."
    fi
}

echo "Checking pre-requisites..."

# Pre-requisite for dundalek/lazy-lsp.nvim
install_if_not_exists "nix" "curl -L https://nixos.org/nix/install | sh"
# Pre-requisite for github/copilot.vim
install_if_not_exists "nvm" "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash"
install_if_not_exists "node" "nvm install 20"

echo "Done!"
