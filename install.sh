#!/bin/sh

# Prepare to install dependencies
sudo apk update
sudo apk add zoxide bat mise navi

# Upgrade NeoVim
sudo apk add --upgrade --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community neovim

# Upgrade FZF
sudo apk del fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
bash ~/.fzf/install --all

# chmod +x ./mise-tasks/*
# mise trust
# mise install
ln -sf "$(pwd)/.gitconfig" ~/.gitconfig
# ln -sf "$(pwd)/nvim" ~/.config/nvim
# ln -sf "$(pwd)/.zshrc" ~/.zshrc
# ln -sf "$(pwd)/.cheat" ~/.cheat
