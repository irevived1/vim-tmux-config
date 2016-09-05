#!/bin/sh

brew update
brew upgrade

brew install tmux
brew uninstall vim
brew install vim --with-lua

PA=~/Documents/vim-tmux-config

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

cp $PA/vim-ruby-flatiron ~/.vimrc
cp $PA/tmux.conf ~/.tmux.conf

vim +BundleInstall +qall

ls ~/Library/Fonts/

if [ $? = 0 ]; then
  echo Good
else
  mkdir -p ~/Library/Fonts/
fi

mkdir ~/.vim/colors/

cp $PA/colors/* ~/.vim/colors/

cp $PA/fonts/* ~/Library/Fonts/

cat $PA/erubysign >> ~/.vim/bundle/vim-ruby/ftplugin/eruby.vim

SN=~/.vim/bundle/vim-snippets/snippets

# cat $SN/rails.snippets >> $SN/ruby.snippets

cat $SN/html.snippets >> $SN/eruby.snippets

brew install python3

# cd ~/.vim/bundle/YouCompleteMe && python3 ./install.py --clang-completer

rm -rf ~/vim-tmux-config
