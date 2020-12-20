#!/bin/bash

# Confirm before proceeding
read -p "Are you sure you want to run zsh setup script? [y/N] : " yn
case $yn in
	[Yy]* ) break;;
	[Nn]* ) exit 0;;
	* ) exit 1;;
esac

# Set zsh as defualt user shell
chsh -s $(which zsh)

# Download extras
mkdir -p $HOME/.config/extras
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.config/zsh/extras/powerlevel10k
git clone --depth=1 https://github.com/kazhala/dotbare.git $HOME/.config/zsh/extras/dotbare

# Link zshrc
ln -sfv $HOME/.config/zsh/zshrc.zsh $HOME/.zshrc

# Zsh
sudo ln -sfv $HOME/.config/zsh/zshrc.zsh /root/.zshrc
sudo rm -rf /root/.config/zsh
sudo ln -sfv $HOME/.config/zsh -t /root/.config

# Neovim
sudo rm -rf /root/.config/nvim
sudo ln -sfv $HOME/.config/nvim -t /root/.config

# Ranger
sudo rm -rf /root/.config/ranger
sudo ln -sfv $HOME/.config/ranger -t /root/.config
