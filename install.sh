#!/bin/sh

# Codespaces Dotfiles based on: https://github.com/dcreager/dotfiles/blob/main/install

if [ -z "$USER" ]; then
    USER=$(id -un)
fi

echo >&2 "====================================================================="
echo >&2 " Setting up codespaces environment"
echo >&2 ""
echo >&2 " USER        $USER"
echo >&2 " HOME        $HOME"
echo >&2 "====================================================================="

# Make passwordless sudo work
export SUDO_ASKPASS=/bin/true

# Prepare to install dependencies
sudo apk update

# mise (alternative to `asdf`)
sudo apk add mise

# zellij (alternative to `tmux`)
sudo apk add zellij

# zoxide
sudo apk add zoxide

# zsh
sudo apk add zsh-vcs
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Bat
sudo apk add bat

mkdir -p "$(bat --config-dir)/themes"
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Latte.tmTheme
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
bat cache --build

# basic dotfiles config
cp ./.bat "$(bat --config-dir)/config"
cp ./.zshrc $HOME/.zshrc
cp ./.gitconfig $HOME/.gitconfig

# Install fzf
mise use --global fzf@latest

# Install neovim v0.11.4, not working right now...
# mise use --global neovim@latest #throwing weird alpine only issues
# sudo rm -rf /usr/bin/nvim
# sudo apk add neovim
# curl -Lo neovim.tar.gz https://github.com/neovim/neovim/releases/download/v0.11.4/nvim-linux-x86_64.tar.gz

# Tasks
sudo sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d
sudo mv bin/task /bin/task
cp ./Taskfile.yml /workspaces/
cp ./docker-containers.sh /workspaces/
chmod +x /workspaces/docker-containers.sh

# Personal Dotfiles
git clone https://git.basking.monster/gaiety/dotfiles.git $HOME/dotfiles
cd $HOME/dotfiles
ln -s "$(pwd)/nvim" ~/.config/nvim
