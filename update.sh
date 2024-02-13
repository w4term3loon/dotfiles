#!/bin/zsh

rm .zshrc
cp ~/.zshrc .

rm .tmux.conf
cp ~/.tmux.conf .

rm -r .config

mkdir -p .config/alacritty
cp ~/.config/alacritty/alacritty.toml .config/alacritty

mkdir -p .config/nvim
cp ~/.config/nvim/init.vim .config/nvim
