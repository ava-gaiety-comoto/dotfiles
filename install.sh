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

cd $HOME

# Make passwordless sudo work
export SUDO_ASKPASS=/bin/true

# I'd like to use fish, please
# sudo apt-get install -y fish
# sudo chsh -s /usr/bin/fish $USER

# Bat

mkdir -p "$(bat --config-dir)/themes"
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Latte.tmTheme
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
bat cache --build

# Install fzf
FZF_VERSION=0.30.0
curl -L https://github.com/junegunn/fzf/releases/download/${FZF_VERSION}/fzf-${FZF_VERSION}-linux_amd64.tar.gz | tar xzC $HOME/bin

# Install neovim
NVIM_VERSION=0.7.0
sudo apt-get install -y libfuse2
curl -L -o $HOME/bin/nvim https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim.appimage
chmod a+x $HOME/bin/nvim

# Personal Dotfiles
git clone https://git.basking.monster/gaiety/dotfiles.git dotfiles
cd dotfiles
ln -s "$(pwd)/nvim" ~/.config/nvim
ln -s "$(pwd)/fish" ~/.config/fish
cd $HOME
