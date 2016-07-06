set shell=/bin/bash

set nocompatible              " required
filetype off                  " required



" ================ PLUGINS =====================

" Setup Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'chriskempson/base16-vim'
"Plugin 'tmhedberg/SimpylFold'
Plugin 'ntpeters/vim-better-whitespace'

"Autocompletion
Bundle 'Valloric/YouCompleteMe'

"Syntax Checking
Plugin 'scrooloose/syntastic'

" Function tag jumping
Plugin 'majutsushi/tagbar'

" Git gutter
Plugin 'airblade/vim-gitgutter'

" Jedi autocompletion
Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'

" Easy commenting/uncomentting (gcc)
Plugin 'tomtom/tcomment_vim'

" Simple writing mode
Plugin 'junegunn/goyo.vim'

" Fuzzy file search
Plugin 'ctrlpvim/ctrlp.vim'

" Surround shit with shit
Plugin 'tpope/vim-surround'

" Laziness
Plugin 'Chiel92/vim-autoformat'

call vundle#end()            " required
filetype plugin indent on    " required


" ================ Remaps ===================

" Kill old habits
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

"Tagbar
nmap <F8> :TagbarToggle<CR>

"double tap i to escape
imap ii <Esc>

" ================ Theming ==================

let base16colorspace=256
colorscheme base16-chalk
set background=dark

" Python highlighting
let python_highlight_all = 1

" ================ Indentation ==============

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

filetype plugin on
filetype indent on

"Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points


" ================ Syntax stuff =============

set encoding=utf-8
syntax enable

" Spaces, not tabs
set tabstop=4
set shiftwidth=4
set expandtab

" Enable folding
set foldmethod=indent
set foldlevel=99
let g:SimpylFold_docstring_preview=1

" Automatically change directory to working directory
set autochdir

" Highlight line cursor
set cursorline

set nu
set relativenumber
" Func for toggling or untoggling rel numbers
function! NumberToggle()
    if(&relativenumber == 1)
        set number
    else
        set relativenumber
    endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>


let g:SuperTabCrMapping=1

autocmd BufWritePre *.py :%s/\s\+$//e
autocmd BufWritePre *.cc :%s/\s\+$//e

" Spell check if a markdown file
autocmd BufRead,BufNewFile *.md setlocal spell

set backspace=indent,eol,start

