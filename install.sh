#!/bin/sh

brew update
brew upgrade

brew install tmux
brew uninstall vim
brew install vim --with-lua

PA=$HOME/vim-tmux-config

git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim

cp $PA/vim-ruby-flatiron $HOME/.vimrc
cp $PA/tmux.conf $HOME/.tmux.conf

ls $HOME/Library/Fonts/

if [ $? = 0 ]; then
  echo Good
else
  mkdir -p $HOME/Library/Fonts/
fi

mkdir $HOME/.vim/colors/

cp $PA/colors/* $HOME/.vim/colors/

cp $PA/fonts/* $HOME/Library/Fonts/

cp $PA/onedark.itermcolors $HOME/onedark.itermcolors
cp $PA/deepspace.itermcolors $HOME/deepspace.itermcolors

vim +BundleInstall +qall

cat $PA/erubysign >> $HOME/.vim/bundle/vim-ruby/ftplugin/eruby.vim

# SN=$HOME/.vim/bundle/vim-snippets/snippets

# cat $SN/rails.snippets >> $SN/ruby.snippets

# cat $SN/html.snippets >> $SN/eruby.snippets

brew install python3

# cd ~/.vim/bundle/YouCompleteMe && python3 ./install.py --clang-completer

rm -rf $HOME/vim-tmux-config
