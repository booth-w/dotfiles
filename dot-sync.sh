#!/usr/bin/env bash


if [ ! -d ~/projects/dotfiles ]; then
	mkdir -p ~/projects
	git clone https://github.com/booth-w/dotfiles.git ~/projects/dotfiles
fi

cd ~/projects/dotfiles
git pull

cp .bashrc ~/.bashrc
cp -r awesome ~/.config/
cp -r bottom ~/.config/
cp -r fastfetch ~/.config/
cp -r kitty ~/.config/
cp -r nvim ~/.config/
cp -r rofi ~/.config/
cp -r superfile ~/.config/
cp dot-sync.sh ~/scripts/
