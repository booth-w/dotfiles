#!/usr/bin/env bash


set -e
cd ~/projects/dotfiles/

rm -rf .bashrc
rm -rf awesome/
rm -rf bottom/
rm -rf fastfetch/
rm -rf kitty/
rm -rf nvim/
rm -rf rofi/
rm -rf superfile/

cp -r ~/.bashrc .
cp -r ~/.config/awesome/ .
cp -r ~/.config/bottom/ .
cp -r ~/.config/fastfetch/ .
cp -r ~/.config/kitty/ .
cp -r ~/.config/nvim/ .
cp -r ~/.config/rofi/ .

mkdir -p ./superfile/
cp -r ~/.config/superfile/config.toml ./superfile/
cp -r ~/.config/superfile/hotkeys.toml ./superfile/

cp ~/scripts/dot-sync-save.sh .
cp ~/scripts/dot-sync-load.sh .

lazygit
