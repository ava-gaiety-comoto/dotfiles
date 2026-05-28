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

# Comoto Helpers
git clone git@github.com:ava-gaiety-comoto/comoto-shell-helpers.git $HOME/comoto-shell-helpers
cd $HOME/comoto-shell-helpers
chmod +x $HOME/comoto-shell-helpers/**/*.sh
echo 'alias c="$HOME/comoto-shell-helpers/scripts.sh"' >> ~/.zshrc
echo 'alias cr="sh $HOME/comoto-shell-helpers/history-read.sh"' >> ~/.zshrc
echo 'alias cR="sh $HOME/comoto-shell-helpers/history-read.sh -t"' >> ~/.zshrc
