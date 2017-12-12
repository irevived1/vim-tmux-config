call plug#begin('~/.local/share/nvim/plugged')

Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'scrooloose/nerdtree'
Plug 'vim-syntastic/syntastic'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'SirVer/ultisnips'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'majutsushi/tagbar'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'benmills/vimux'

Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'sheerun/vim-polyglot'
Plug 'ap/vim-css-color'
Plug 'epilande/vim-react-snippets'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

Plug 'alvan/vim-closetag'
Plug 'tpope/vim-endwise'
Plug 'terryma/vim-multiple-cursors'

"THEME
Plug 'mhartington/oceanic-next'
Plug 'rakr/vim-one'

call plug#end()

" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Or if you have Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif

" Theme
syntax enable
set background=dark        " for the light version
" let g:one_allow_italics = 1 " I love italic for comments
" colorscheme one
colorscheme OceanicNext

inoremap df <Esc>
cnoremap df <Esc>

" Config
set number
set relativenumber
set clipboard=unnamed

let mapleader = ","
nmap <leader>n :NERDTreeToggle<cr>
nnoremap <silent><expr> <Leader>h (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

set listchars=tab:\ \ ,eol:¬
set list

"set autoindent
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab

nnoremap <Tab> gt
nnoremap <S-Tab> gT

let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><S-tab> pumvisible() ? "\<c-p>" : "\<S-tab>"
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nnoremap ; :
nnoremap <C-[> :FZF<CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <C-b> :Windows<CR>

inoremap <C-z> <space>
nnoremap <C-z> <space>



" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:closetag_filenames = "*.erb,*.html.erb,*.html,*.xhtml,*.phtml,*.js"
let g:jsx_ext_required = 0

set lazyredraw

" UI setting
set laststatus=2
"
set cursorline

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tabs = 1

let g:airline_theme='bubblegum'
let g:airline_powerline_fonts = 1
let g:promptline_theme = 'airline'
" colorscheme onedark

au VimEnter * IndentGuidesEnable
let g:indent_guides_auto_colors = 0
augroup Group1  
  autocmd!
  autocmd InsertEnter * set timeoutlen=200
  autocmd InsertLeave * set timeoutlen=200
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#394453 ctermbg=darkgrey
augroup END
" hi IndentGuidesEven guibg=#394453 ctermbg=darkgrey

"" TMUX functions
"❯
      " \'b'    : '#(basename #{pane_current_path})',
      " \'b'    : ['#(basename $(dirname #{pane_current_path}))','#(basename #{pane_current_path})'],
      " \'b'    : ['#(basename $(dirname #{pane_current_path}) | sed ''s/\\\\///g'')','#(basename #{pane_current_path})'],
      " \'b'    : '#(#{pane_current_path} | sed ''s/\\\\///g'')',
      " \'cwin' : ['#I', '#W', '#F'],
" echo "${PWD/#$HOME/\~}"
let g:tmuxline_preset = {
      \'a'    : '#(whoami)',
      \'b'    : '#(echo #{pane_current_path} | sed "s|$HOME|\~|" | sed ''s/\\\\//  /g'')',
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W '],
      \'x'    : ' #(battery -t)',
      \'y'    : ['%A', '%H:%M', '%Y-%m-%d'],
      \'z'    : '#h'}
      " \'x'    : ' #(battery -t)',




function! NumberToggle()
if(&relativenumber == 1)
  set relativenumber!
  else
  set relativenumber
  endif
endfunc


function! P_Compile()
  let i =  expand('%:e')
  if ( i == "rb" )
    let c =  " ruby " .expand('%:p')
    return c
  elseif (i == "cpp" )
    let c =  " g++ " .expand('%:p') ." -o " .expand('%:p:r') ." && " .expand('%:p:r')
    return c
  elseif ( i == "c" )
    let c =  " gcc " .expand('%:p') ." -o " .expand('%:p:r') ." && " .expand('%:p:r')
    return c
  elseif ( i == "java" )
    let c =  " javac " .expand('%:p') ." &&  java -classpath " .expand('%:p:h')." ".expand('%:t:r')
    return c
  elseif ( i == "pl" )
    let c =  " perl " .expand('%:p')
    return c
  elseif ( i == "py" )
    let c =  " python " .expand('%:p')
    return c
  elseif ( i == 'js' )
    let c =  " node " .expand('%:p')
    return c
  else
    let c = " echo lol no compiler found "
    return c
  endif
endfunc


function! K_Compile()
  let i =  expand('%:e')
  if (i == "cpp" )
    let c =  " g++ " .expand('%:p') ." -lcrypto -o " .expand('%:p:r') ." && " .expand('%:p:r')
    return c
  elseif ( i == "c" )
    let c =  " gcc " .expand('%:p') ." -lcrypto -o " .expand('%:p:r') ." && " .expand('%:p:r')
    return c
  else
    let c = " echo lol no compiler found "
    return c
  endif
endfunc

function! Linter()
  let i =  expand('%:e')
  if (i == "rb" )
    let c =  " rubocop -a " .expand('%:p')
    return c
  elseif ( i == "js" )
    let c =  " eslint --fix " .expand('%:p')
    return c
  else
    let c = " echo lol unknown extension"
    return c
  endif
endfunc






"remove below when done, tmp configs
nnoremap <leader>z :call NumberToggle()<cr>
inoremap ® <ESC>:call VimuxRunCommand(getline('.') ." ")<CR>0D

nmap <leader>q  :w \| call VimuxRunCommand(P_Compile()) <CR>
nmap <leader>w  :w \| call VimuxRunCommand(K_Compile()) <CR>
nmap <leader>k  :w \| call VimuxRunCommand("!!") <CR>
nmap <leader>fo :w \| call VimuxRunCommand(Linter()) <CR>
" nmap <leader>k  :w \| call VimuxRunLastCommand() <CR>
" for scrolling in running pane
let g:VimuxRunnerIndex = 1
nmap µ :execute "!tmux copy-mode -t " .VimuxRunnerIndex <CR><CR>
nmap ≤ :call VimuxSendKeys('C-d') <CR>
nmap ≥ :call VimuxSendKeys('C-u') <CR>

nmap <Leader>co :call VimuxOpenPane()<CR>
nmap <Leader>cc :call VimuxInterruptRunner()<CR>
nmap <Leader>j :call VimuxInspectRunner()<CR>
nmap <Leader><CR> :call VimuxSendKeys('enter') <CR>
nmap <leader>ce :call VimuxRunCommand(" exit ") <CR>
nmap <Leader>ci :let VimuxRunnerIndex = 

nmap <leader>3s  :w \| call VimuxRunCommand(" rspec --f-f") <CR>
nmap <leader>2s  :w \| call VimuxRunCommand(" npm test ") <CR>

nmap <leader>3s  :w \| call VimuxRunCommand(" mocha test/*".expand('%:t:r')."*") <CR>

nmap <leader>S  :w \| call VimuxRunCommand(" learn && learn submit") <CR>
"nmap <leader>S :w \| call VimuxRunCommand("learn && learn submit && exit") <CR>
nmap <leader>1s :call VimuxRunCommand(" rspec " .expand('%:p'). ":".line('.')) <CR>

nmap <leader>pry :call VimuxRunCommand(" pry ") <CR>
nmap <leader>r :call VimuxRunCommand(getline('.') ." ") <CR>
vmap <leader>r :call VimuxRunCommand(getline('.') ." ") <CR>


nmap <leader>a "a
nmap <leader>s "s
nmap <leader>d "d
nmap <leader>f "f
nmap <leader>g "g

vmap <leader>a "a
vmap <leader>s "s
vmap <leader>d "d
vmap <leader>f "f
vmap <leader>g "g

nnoremap <leader>t :TagbarToggle<CR>

