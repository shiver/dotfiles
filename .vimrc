set nocompatible              " be iMproved, required
filetype off                  " required

" Make sure we have Vundle installed
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
	echo "Installing Vundle.."
	echo ""
	silent !mkdir -p ~/.vim/bundle
	silent !git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
	let iCanHazVundle=0
endif

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" My plugins
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tomasr/molokai'
Plugin 'scrooloose/syntastic'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'rust-lang/rust.vim'
Plugin 'Yggdroot/indentLine.git'
Plugin 'Raimondi/delimitMate.git'
Plugin 'fatih/vim-go'
Plugin 'airblade/vim-gitgutter'
" Relative numbering, not really helpful.
" Plugin 'myusuf3/numbers.vim'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'junegunn/vim-easy-align'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'joshdick/onedark.vim'
Plugin 'mileszs/ack.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'leafgarland/typescript-vim'

call vundle#end()

filetype plugin indent on    " required
syntax on

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
