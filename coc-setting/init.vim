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
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'benmills/vimux'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'puremourning/vimspector'

Plug 'luochen1990/rainbow'
Plug 'sheerun/vim-polyglot'
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


if has('nvim')
  Plug 'nvim-tree/nvim-tree.lua'
  Plug 'nvim-tree/nvim-web-devicons'
else
  Plug 'scrooloose/nerdtree'
endif

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
set mouse=a

" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Or if you have Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif

" Theme
syntax enable
set background=dark        " for the light version
let g:one_allow_italics = 1 " I love italic for comments
colorscheme one
" highlight Comment cterm=italic gui=italic
"
let g:coc_global_extensions=[ 'coc-lists', 'coc-emmet', 'coc-calc', 'coc-tsserver', 'coc-snippets', 'coc-html', 'coc-css', 'coc-json', 'coc-eslint', 'coc-java', 'coc-go', 'coc-flutter', 'coc-pairs']
let g:python3_host_prog="/usr/bin/python3"
" let g:python2_host_prog="/usr/bin/python2"
let g:ruby_host_prog="/usr/bin/ruby"

let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

inoremap df <Esc>
nnoremap ' `
nnoremap ` '

" Config
set number
set relativenumber
" set clipboard=unnamed
set clipboard=unnamedplus

let mapleader = "\<Space>"

if has('nvim')
  lua vim.g.loaded_netrw = 1
  lua vim.g.loaded_netrwPlugin = 1
  lua vim.opt.termguicolors = true
  lua require("nvim-tree").setup()
  nmap <leader>n :NvimTreeToggle<cr>
  nmap <leader>N :NvimTreeFindFile<cr>
else
  nmap <leader>n :NERDTreeToggle<cr>
  nmap <leader>N :NERDTreeFind<cr>
endif

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

let g:coc_snippet_prev = '<C-k>'
" inoremap <silent><expr> <C-n> coc#pum#visible() ? "\<C-n>" : coc#refresh()
" inoremap <silent><expr> <C-n> coc#pum#visible() ? coc#pum#next(1) : "\<C-n>"

inoremap <silent><expr> <C-j>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ coc#refresh()

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" :nmap - Display normal mode maps
" :imap - Display insert mode maps
" :vmap - Display visual and select mode maps
" :smap - Display select mode maps
" :xmap - Display visual mode maps
" :cmap - Display command-line mode maps
" :omap - Display operator pending mode maps

" Symbol renaming.
nmap <leader>cr <Plug>(coc-rename)
nmap <silent> <C-f> <Plug>(coc-cursors-position)

"retab
" nmap <C-w>t :set tabstop=2 \| retab! \| set tabstop=2 <cr>

nnoremap <leader>w <C-w>
nnoremap <C-w> <C-i>
nnoremap <Tab> gt
nnoremap <S-Tab> gT

nnoremap ; :
nnoremap <C-p> :CocList files<CR>
nnoremap <C-[> :CocListResume<CR>
nnoremap <C-b> :CocList windows<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
nnoremap <leader>v :call ShowDocumentation()<CR>

if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

nnoremap <leader>fw :CocSearch 
nmap gd	:call CocAction('jumpDefinition', 'tabe')<CR>
inoremap <C-z> <space>

vmap <leader>pf  <Plug>(coc-format-selected)
nmap <leader>pf  <Plug>(coc-format-selected)
" nmap <leader>fp  :CocCommand prettier.formatFile<CR>
nmap <leader>fp  :CocCommand eslint.executeAutofix<CR>
nmap <leader>cm  :CocCommand 
autocmd FileType dart nmap <buffer> <leader>cf :CocCommand flutter.

let g:closetag_filenames = "*.erb,*.html.erb,*.html,*.xhtml,*.phtml,*.js"

set lazyredraw

" UI setting
set laststatus=2
"
set cursorline

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tabs = 1

" brew tap homebrew/cask-fonts && brew install --cask font-dejavu-sans-mono-nerd-font
let g:airline_theme='bubblegum'
let g:airline_powerline_fonts = 1
let g:promptline_theme = 'airline'

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
  elseif ( i == 'go' )
    let c =  " go run " .expand('%:p')
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

function! GetSelection()
    let old_reg = getreg("v")
    normal! gv"vy
    let raw_search = getreg("v")
    call setreg("v", old_reg)
    return substitute(escape(raw_search, '\/.*$^~[]'), "\n", "\<CR>", "g")
endfunction

"remove below when done, tmp configs
nnoremap <leader>z :call NumberToggle()<cr>

nmap <leader>cq  :w \| call VimuxRunCommand(P_Compile()) <CR>
" nmap <leader>w  :w \| call VimuxRunCommand(K_Compile()) <CR>
nmap <leader>k  :w \| call VimuxRunCommand("!!") <CR>
nmap <leader>fo :w \| call VimuxRunCommand(Linter()) <CR>

let g:VimuxRunnerIndex = 1
nmap µ :execute "!tmux copy-mode -t " .VimuxRunnerIndex <CR><CR>

nmap <Leader>co :call VimuxOpenPane()<CR>
nmap <Leader>cc :call VimuxInterruptRunner()<CR>
nmap <Leader>j :call VimuxInspectRunner()<CR>
nmap <Leader><CR> :call VimuxSendKeys('enter') <CR>
nmap <leader>ct :call VimuxRunCommand(" exit ") <CR>
nmap <Leader>ci :let VimuxRunnerIndex = 

nmap <leader>3s  :w \| call VimuxRunCommand(" bundle exec rspec --f-f") <CR>
nmap <leader>3s  :w \| call VimuxRunCommand(" mocha test/*".expand('%:t:r')."*") <CR>

nmap <leader>S  :w \| call VimuxRunCommand(" learn && learn submit") <CR>
nmap <leader>1s :call VimuxRunCommand(" bundle exec rspec " .expand('%:p'). ":".line('.')) <CR>

nmap <leader>ce :call VimuxRunCommand(getline('.') ." ") <CR>
vmap <leader>ce :<C-u>call VimuxRunCommand(GetSelection()) <CR>

nmap <leader>fn :let @*=expand('%:t') \| let @+=expand('%:t')<CR>
nmap <leader>fr :let @*=expand('%') \| let @+=expand('%')<CR>
nmap <leader>ap :let @*=expand('%:p') \| let @+=expand('%:p')<CR>

xmap <leader><space>  <Plug>(coc-codeaction-selected)
nmap <leader><space>  <Plug>(coc-codeaction-selected)
" Remap keys for applying code actions at the cursor position
nmap <leader><space>c  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader><space>s  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
nnoremap <silent><nowait> <leader>cl :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <leader>cs :<C-u>CocList -I symbols<cr>
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

nmap <leader>a "a
nmap <leader>s "s
" nmap <leader>d "d
nmap <leader>f "f
nmap <leader>g "g

vmap <leader>a "a
vmap <leader>s "s
" vmap <leader>d "d
vmap <leader>f "f
vmap <leader>g "g

nnoremap <CR> o<ESC>
inoremap <C-z> <space>
nnoremap <C-z> <space>

" must define after loading vimspector
nmap <leader>dc <Plug>VimspectorContinue()
nmap <leader>dp <Plug>VimspectorStop()
nmap <leader>ds <Plug>VimspectorRestart()
" nmap <leader>dp <Plug>VimspectorPause()<CR>
nmap <leader>dt <Plug>VimspectorToggleBreakpoint()
" nmap <leader>d <Plug>VimspectorToggleConditionalBreakpoint()<CR>
" nmap <leader>d <Plug>VimspectorAddFunctionBreakpoint()<CR>
nmap <leader>do <Plug>VimspectorStepOver()
nmap <leader>di <Plug>VimspectorStepInto()
nmap <leader>du <Plug>VimspectorStepOut()
nmap <leader>dn <Plug>VimspectorRunToCursor()
nmap <leader>dv <Plug>VimspectorBalloonEval()
xmap <leader>dw <Plug>VimspectorBalloonEval()

function! VimspectorEvalFunc(is_visual)
  execute ":VimspectorEval " . (a:is_visual ? GetSelection() : getline('.'))
endfunction

command! -nargs=1 VimspectorEvalFuncCmd call VimspectorEvalFunc(<args>)
xmap <Leader>dr :<C-u>VimspectorEvalFuncCmd(1)<CR>
nnoremap <Leader>dr :VimspectorEvalFuncCmd(0)<CR>

nmap <leader>dw :VimspectorWatch 
nmap <leader>dx :VimspectorReset<CR>
