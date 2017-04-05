# vim and tmux config

## These config files are meant for osx using iTerm2

### If colors are not displaying correctly within tmux, add this into your .bashrc or .bash_profile:
```
export TERM=xterm-256color
```
### Run the following command in your bash to see working TrueColor:

```
curl -s https://raw.githubusercontent.com/JohnMorales/dotfiles/master/colors/24-bit-color.sh | bash
```

### vim config with mapping and suggested plugins
*vimrc*

 - some recommended plugins

### vim config with compile + run functions (currently working for Ruby, C++ with g++, C with gcc, Java, Perl, and Python)
*vim-functions*

 - leader + q = save, compile and run current file
 - leader + w = save, run C++/C with -lcrypto only

### vim for flatiron students using Learn IDE
*vim-flatiron-rspec-learn-submit*

 - leader + s = rspec with fast fail
 - leader + S = auto learn, learn submit and logout
 - leader + Q = rspec selected file
 - leader + 1q = rspec selected file with fast fail
 - leader + 1s = rspec on the selected line, must be in a spec.rb file 
 - may not work for improper file names

### Tmux config:
*tmux.config - make sure you have Tmux Plugin Manager installed*

 - Ctrl + a is the prefix
 - prefix + V = split window vertically
 - prefix + v = split window horizontally
 - prefix + J/K/H/L = resize-pane
 - Ctrl + h/j/k/l = move between panes, works with vim panes as well

Note: copy mode is set to vi-mode

#### Colors and fonts are from other repositories made by other users. Thank them for it!
