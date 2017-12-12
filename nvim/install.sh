#!/bin/sh

PA=$HOME/vim-tmux-config

git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim

mkdir -p ~/.config/nvim/
cp ./init.vim ~/.config/nvim/init.vim
cp ./tmux.conf ~/.tmux.conf
