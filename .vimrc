set nocompatible              " be iMproved, required

" Ensure vim-plug is installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tomasr/molokai'
Plug 'scrooloose/syntastic'
Plug 'ntpeters/vim-better-whitespace'
Plug 'rust-lang/rust.vim'
Plug 'Yggdroot/indentLine'
Plug 'Raimondi/delimitMate'
Plug 'fatih/vim-go'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/vim-easy-align'
Plug 'christoomey/vim-tmux-navigator'
Plug 'joshdick/onedark.vim'
Plug 'mileszs/ack.vim'
Plug 'honza/vim-snippets'
Plug 'leafgarland/typescript-vim'
Plug 'prettier/vim-prettier'

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf'

" Disabled plugins
" Plug 'myusuf3/numbers.vim'
" Plug 'Valloric/YouCompleteMe'
" Plug 'SirVer/ultisnips'

call plug#end()

filetype plugin indent on    " required
syntax on

set noeb vb t_vb=
set ff=unix
set encoding=utf-8
set showcmd
set modeline
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set smartindent
set expandtab
set autoread
set ignorecase
set smartcase
set incsearch
set nu
set ruler
set ls=2
set t_Co=256
" disable background colour erasing
set t_ut=
set mouse=a
set colorcolumn=90
set nobackup
set noswapfile
colorscheme onedark
set wildmenu
set wildmode=longest:list,full
set clipboard=unnamed
" gvim specific settings
set guioptions=
set guifont=Tamsyn\ 9

" No Wrapping for HTML files
au FileType html set nowrap
au FileType html set textwidth=0
au FileType html set wrapmargin=0

au FileType php set nowrap
au FileType php set textwidth=0
au FileType php set wrapmargin=0

" Strip trailing whitespace for all filetypes
autocmd BufWritePre * StripWhitespace
" let g:better_whitespace_filetypes_blacklist=['diff', 'gitcommit', 'unite', 'qf', 'help']

" Typescript plugin seems to be buggy
autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript

" syntastic settings
" PHP
let g:syntastic_php_checks = ['php', 'phpcs', 'phpmd']
let g:syntastic_mode_map = {'mode' : 'passive'}

" Python
let g:syntastic_python_checkers=['flake8', 'python']
let g:syntastic_python_flake8_args='--ignore=E501'

" Javascript
let g:syntastic_javascript_checkers = ['eslint']

" ctrlp settings
let g:ctrlp_custom_ignore = {
	\ 'dir': '\.git$\|\.hg$\|\.svn$\|__pycache__$',
	\ 'file': '\.pyc$\|\.swp$',
	\ }
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_files = 0
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" NERDTree settings
let NERDTreeIngore=['\.pyc$', '\.swp$', '__pycache__']

" Airline settings
let g:airline_theme="badwolf"

" vim-better-whitespace
let g:strip_whitespace_on_save = 1

" indent guide
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#09AA08'
let g:indentLine_char = '│'

" numbers.vim
let g:numbers_exclude = ['tagbar', 'nerdtree']

" Ack to use ag instead
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

if executable('rg')
    let g:ackprg = 'rg --vimgrep --no-heading'
endif

" vim-prettier settings
let g:prettier#config#parser = 'babylon'
let g:prettier#config#print_width = 80
let g:prettier#config#tab_width = 2
let g:prettier#config#single_quote = 'false'
let g:prettier#config#prose_wrap = 'preserve'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#trailing_comma = 'none'
let g:prettier#config#jsx_bracket_same_line = 'false'
let g:prettier#config#arrow_parens = 'avoid'

" vim-prettier autoformat
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue,*.yaml,*.html Prettier

" Custom key bindings
let mapleader = ","
nnoremap <leader>sap :Ack<space>
nnoremap <leader>c :SyntasticCheck<cr>
nnoremap <leader>ce :Errors<cr>
nnoremap <leader>gd :YcmCompleter GoTo<cr>
nnoremap <leader>pf :CtrlP<cr>
nnoremap <leader>pb :CtrlPBuffer<cr>

" Save and load sessions
map <leader>ls :mksession! .vim_session<cr>
map <leader>lr :source .vim_session<cr>

map <F7> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>
