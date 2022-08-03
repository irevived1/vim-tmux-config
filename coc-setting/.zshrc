alias jk='nvim'
alias ll='ls -alF --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias ls='ls -GFh --color=auto'
alias googlebrowse='open -a "Google Chrome"'
alias showmeallthecolors='curl -s https://raw.githubusercontent.com/JohnMorales/dotfiles/master/colors/24-bit-color.sh | bash'

bindkey -e
bindkey '^[[1;3C' forward-word
bindkey '^[[1;3D' backward-word

git_prompt() {
  local branch_symbol=" "
  local b_bg="\e[48;5;236m"
  if hash git 2>/dev/null; then
    if branch=$( { git symbolic-ref --quiet HEAD || git rev-parse --short HEAD; } 2>/dev/null); then
      branch=${branch##*/}
      printf "%*s%s\n" $(( COLUMNS-1 ))  "${branch_symbol}${branch:-unknown}"
      return
    fi
  fi
  return 1
}

function precmd() {
  git_prompt
}

autoload -U colors && colors
PS1="%{$fg[blue]%}❯%(?.%F{magenta}.%F{red})❯%{$reset_color%} "
