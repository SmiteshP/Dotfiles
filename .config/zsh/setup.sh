#!/bin/sh

read -p "Are you sure you want to run zsh setup script? [y/N] : " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
	exit 1
fi

mkdir -p $HOME/.config/extras
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.config/zsh/extras/powerlevel10k
git clone --depth=1 https://github.com/kazhala/dotbare.git $HOME/.config/zsh/extras/dotbare

ln -sfv $HOME/.config/zsh/zshrc.zsh $HOME/.zshrc

# Zsh
sudo ln -sfv $HOME/.config/zsh/zshrc.zsh /root/.zshrc
sudo ln -sfv $HOME/.config/zsh -t /root/.config

# Neovim
sudo ln -sfv $HOME/.config/nvim -t /root/.config

# Ranger
sudo ln -sfv $HOME/.config/ranger -t /root/.config
