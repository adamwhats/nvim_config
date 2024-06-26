#!/bin/bash

set -e

# Function to print messages
print_info() {
	echo -e "\033[1;32m$1\033[0m"
}

# Function to print errors
print_error() {
	echo -e "\033[1;31mError: $1\033[0m"
}

# Check if a command exists
command_exists() {
	command -v "$1" >/dev/null 2>&1
}

# Check if lazygit is installed
if ! command_exists lazygit; then
	print_info "Installing Lazygit..."
	LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
	curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
	tar xf lazygit.tar.gz lazygit
	sudo install lazygit /usr/local/bin
	rm lazygit lazygit.tar.gz
else
	print_info "Lazygit is already installed. Skipping installation"
fi

print_info "Updating package lists..."
sudo apt update

print_info "Installing prerequisites..."
sudo apt install -y \
	build-essential \
	curl \
	fd-find \
	gcc \
	python3-venv \
	ripgrep \
	unzip \
	xclip

print_info "Installing nodejs 20.15"
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# Check if Neovim is already installed and uninstall if necessary
if command_exists nvim; then
	print_info "Uninstalling existing Neovim..."
	sudo apt remove --purge neovim -y
	sudo rm -rf /usr/local/nvim/ /usr/local/bin/nvim
fi

# Neovim installation from GitHub release
NEOVIM_VERSION="0.10.0"
print_info "Downloading Neovim v${NEOVIM_VERSION}..."
curl -LO https://github.com/neovim/neovim/releases/download/v${NEOVIM_VERSION}/nvim-linux64.tar.gz
tar xzf nvim-linux64.tar.gz
sudo mv nvim-linux64 /usr/local/nvim/
sudo ln -sf /usr/local/nvim/bin/nvim /usr/local/bin/nvim
rm nvim-linux64.tar.gz

# Install JetBrains Mono nerd fonts
if ! [ $(ls /usr/local/share/fonts/JetBrains* 2>/dev/null | wc -l) -gt 0 ]; then
	print_info "Installing JetBrains Mono nerd font..."
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
	sudo unzip JetBrainsMono.zip -d /usr/local/share/fonts/
	fc-cache -fv
	rm JetBrainsMono.zip
else
	print_info "JetBrains Mono nerd font is already installed. Skipping installation."
fi

# Print completion message
print_info "Setup complete! Neovim v${NEOVIM_VERSION} and all dependencies have been installed."
print_info "You can start Neovim by running 'nvim' in your terminal."

# Instructions for user
echo -e "\033[1;34mTo use the setup, ensure your terminal emulator supports the configured fonts and settings.\033[0m"
