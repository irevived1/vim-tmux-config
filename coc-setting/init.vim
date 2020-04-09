" check whether vim-plug is installed and install it if necessary
let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
if !filereadable(plugpath)
    if executable('curl')
        let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
        if v:shell_error
            echom "Error downloading vim-plug. Please install it manually.\n"
            exit
        endif
    else
        echom "vim-plug not installed. Please install it manually or install curl.\n"
        exit
    endif
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'benmills/vimux'

Plug 'luochen1990/rainbow'
Plug 'honza/vim-snippets'
Plug 'ap/vim-css-color'
Plug 'epilande/vim-react-snippets'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

Plug 'alvan/vim-closetag'
Plug 'tpope/vim-endwise'

"THEME
Plug 'mhartington/oceanic-next'
Plug 'rakr/vim-one'

call plug#end()


set hidden

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

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
colorscheme one
" colorscheme OceanicNext
"
let g:coc_global_extensions=[ 'coc-lists', 'coc-emmet', 'coc-calc', 'coc-tsserver', 'coc-snippets', 'coc-html', 'coc-css', 'coc-json', 'coc-prettier']
let g:python3_host_prog="/usr/local/bin/python3"
let g:python2_host_prog="/usr/local/bin/python2"
let g:ruby_host_prog="/usr/bin/ruby"

" Symbol renaming.
" nmap <leader>rn <Plug>(coc-rename)

let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

inoremap df <Esc>

" Config
set number
set relativenumber
set clipboard=unnamed

let mapleader = ","
nmap <leader>n :NERDTreeToggle<cr>
nmap <leader>N :NERDTreeFind<cr>
nnoremap <silent><expr> <Leader>h (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

set listchars=tab:\ \ ,eol:¬
set list

"set autoindent
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
  \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

autocmd FileType json syntax match Comment +\/\/.\+$+

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Use <C-j> for both expand and jump (make expand higher priority.)
" imap <C-j> <Plug>(coc-snippets-expand-jump)
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

inoremap <silent><expr> <C-n> pumvisible() ? "\<C-n>" : coc#refresh()

if exists('*complete_info')
  " Use `complete_info` if your (Neo)Vim version supports it.
  " inoremap <expr> <C-j> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-n>\<C-y>"
  inoremap <expr> <C-j> coc#_select_confirm()
else
  imap <expr> <C-j> (pumvisible() && empty(v:completed_item)) != 1 ? "\<C-y>" : "\<C-n>\<C-y>"
endif

" :nmap - Display normal mode maps
" :imap - Display insert mode maps
" :vmap - Display visual and select mode maps
" :smap - Display select mode maps
" :xmap - Display visual mode maps
" :cmap - Display command-line mode maps
" :omap - Display operator pending mode maps

nmap <silent> <C-f> <Plug>(coc-cursors-position)

"retab
" nmap <C-w>t :set tabstop=2 \| retab! \| set tabstop=2 <cr>

nnoremap <Tab> gt
nnoremap <S-Tab> gT

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~ '\s'
" endfunction
"
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

nnoremap ; :
nnoremap <C-p> :CocList files<CR>
nnoremap <C-[> :CocListResume<CR>
nnoremap <C-b> :CocList windows<CR>
nnoremap <leader>fw :CocSearch 
nmap gd	:call CocAction('jumpDefinition', 'drop')<CR>
inoremap <C-z> <space>

vmap <leader>pf  <Plug>(coc-format-selected)
nmap <leader>pf  <Plug>(coc-format-selected)
nmap <leader>fp  :CocCommand prettier.formatFile<CR>

let g:closetag_filenames = "*.erb,*.html.erb,*.html,*.xhtml,*.phtml,*.js"

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
    let c =  " bundle exec rubocop -a " .expand('%:p')
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

let g:VimuxRunnerIndex = 1
nmap µ :execute "!tmux copy-mode -t " .VimuxRunnerIndex <CR><CR>

nmap <Leader>co :call VimuxOpenPane()<CR>
nmap <Leader>cc :call VimuxInterruptRunner()<CR>
nmap <Leader>j :call VimuxInspectRunner()<CR>
nmap <Leader><CR> :call VimuxSendKeys('enter') <CR>
nmap <leader>ce :call VimuxRunCommand(" exit ") <CR>
nmap <Leader>ci :let VimuxRunnerIndex = 

nmap <leader>3s  :w \| call VimuxRunCommand(" bundle exec rspec --f-f") <CR>
nmap <leader>3s  :w \| call VimuxRunCommand(" mocha test/*".expand('%:t:r')."*") <CR>

nmap <leader>S  :w \| call VimuxRunCommand(" learn && learn submit") <CR>
nmap <leader>1s :call VimuxRunCommand(" bundle exec rspec " .expand('%:p'). ":".line('.')) <CR>

nmap <leader>r :call VimuxRunCommand(getline('.') ." ") <CR>
vmap <leader>r :call VimuxRunCommand(getline('.') ." ") <CR>

nmap <leader>fn :let @*=expand('%:t') \| let @+=expand('%:t')<CR>
nmap <leader>fr :let @*=expand('%') \| let @+=expand('%')<CR>
nmap <leader>ap :let @*=expand('%:p') \| let @+=expand('%:p')<CR>

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

nnoremap <CR> o<ESC>
inoremap <C-z> <space>
nnoremap <C-z> <space>
