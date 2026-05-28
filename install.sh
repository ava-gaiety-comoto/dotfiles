#!/bin/sh

# Codespaces Dotfiles based on: https://github.com/dcreager/dotfiles/blob/main/install

# Prepare to install dependencies
sudo apk update
sudo apk add zellij zoxide bat

# setup mise
curl https://mise.run | sh

# basic dotfiles config
cp ./.zshrc $HOME/.zshrc
cp ./.gitconfig $HOME/.gitconfig

# Personal Dotfiles
git clone -b 2026 https://git.basking.monster/gaiety/dotfiles.git $HOME/dotfiles
cd $HOME/dotfiles
chmod +x ./mise-tasks/*
mise trust
mise install
mise run lsp-typescript
ln -sf "$(pwd)/.gitconfig" ~/.gitconfig
ln -sf "$(pwd)/nvim" ~/.config/nvim
ln -sf "$(pwd)/.zshrc" ~/.zshrc

# Upgrade FZF
sudo apk del fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
