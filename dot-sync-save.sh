#!/usr/bin/env bash


cp -r ~/.bashrc ~/projects/dotfiles/
cp -r ~/.config/awesome/ ~/projects/dotfiles/
cp -r ~/.config/bottom/ ~/projects/dotfiles/
cp -r ~/.config/fastfetch/ ~/projects/dotfiles/
cp -r ~/.config/kitty/ ~/projects/dotfiles/
cp -r ~/.config/nvim/ ~/projects/dotfiles/
cp -r ~/.config/rofi/ ~/projects/dotfiles/
cp -r ~/.config/superfile/config.toml ~/projects/dotfiles/superfile/
cp -r ~/.config/superfile/hotkeys.toml ~/projects/dotfiles/superfile/

cp ~/scripts/dot-sync-save.sh ~/projects/dotfiles/scripts/
cp ~/scripts/dot-sync-load.sh ~/projects/dotfiles/scripts/

cd ~/projects/dotfiles/
lazygit
