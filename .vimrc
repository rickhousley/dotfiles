set shell=/bin/bash

let mapleader=","
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
" Plugin 'scrooloose/syntastic'

" Function tag jumping
Plugin 'majutsushi/tagbar'
Plugin 'ludovicchabant/vim-gutentags'

" Git gutter
Plugin 'airblade/vim-gitgutter'

"Fugitive for blame
Plugin 'tpope/vim-fugitive'

" Jedi autocompletion
" Plugin 'davidhalter/jedi-vim' " incompatible with Youcompleteme?
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
" Plugin 'Chiel92/vim-autoformat'

"Auto indent
Plugin 'hynek/vim-python-pep8-indent'

"Expand text selection
Plugin 'terryma/vim-expand-region'

"keep things in sync with disk
Bundle 'djoshea/vim-autoread'

Plugin 'jiangmiao/auto-pairs'


" Better paste
" http://stackoverflow.com/questions/5585129/pasting-code-into-terminal-window-into-vim-on-mac-os-x
Plugin 'ConradIrwin/vim-bracketed-paste'

" Flaking and pep8ing
Plugin 'tell-k/vim-autoflake', {'for': 'python'}
Plugin 'tell-k/vim-autopep8'
Plugin 'benekastah/neomake'

Plugin 'fisadev/vim-isort'

" Enable fzf in vim
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'

call vundle#end()            " required
filetype plugin indent on    " required


" ================ Remaps ===================

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" Kill old habits
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

"Tagbar
nmap <F9> :TagbarToggle<CR>

"double tap i to escape
imap ii <Esc>

"Sudo maps to W
command W w !sudo tee % >/dev/null
"stop annoying snap to top of block on yank 
vmap <silent> y ygv<Esc>;:Clip<CR>  

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

" set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points


" ================ Syntax stuff =============

set encoding=utf-8
syntax enable

set autoindent smartindent
set smarttab
set expandtab
set tabstop=4
set shiftwidth=2
set textwidth=80
set formatoptions-=t formatoptions+=croql

"  Enable folding
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

set clipboard=unnamedplus


" ==================== Misc +++++++++++++++++++++++++++++
filetype plugin indent on      " Filetype detection and custom file plugins + syntax
set hidden                     " Don't abandon buffers moved to the background
set wildmenu                   " Enhanced completion hints in the command line
set wildmode=list:longest,full " Complete longest common match and show possible and wildmenu
set backspace=eol,start,indent " Allow backspacing over indent, eol, start
set complete=.,w,b,u,U,t,i,d   " Scans for tab completion
set diffopt=filler,iwhite      " Diff mode ignores whitespace and align unchanged lines
set history=1000               " Remember 1000 commands
set scrolloff=3                " Start scrolling 3 lines before horizontal window border
set visualbell t_vb=           " Disable visual bells
set shortmess+=A               " Always edit file, even with swapfile
set ttimeoutlen=50
set lazyredraw
set cursorline
set autoread

" Change directory to open file
au BufEnter * if expand('%:p') !~ '://' | cd %:p:h | endif

" Save file on lose focus
au FocusLost * :wa

""""""""""""""""""""""""""""""""
" Undo
" """"""""""""""""""""""""""""""""
set undolevels=10000
if has("persistent_undo")
    set undodir=~/.vim/undo         " Allow undo to persist even after a file is closed
    set undofile
endif

"
" Search settings
" """""""""""""""""""""""""""""""
set ignorecase
set smartcase
set hlsearch
set incsearch
set showmatch


" ==================== neomake settings
set colorcolumn=100 
let g:neomake_python_enabled_makers = ['pyflakes', 'pep8']
" E501 is line length of 80 characters 
let g:neomake_python_pep8_maker = { 'args': ['--max-line-length=105'], } 
autocmd! BufWritePost * Neomake 
let g:neomake_error_sign = { 
            \ 'text': 'E❯', 
            \ 'texthl': 'ErrorMsg', 
            \ } 
hi NeoWarningMsg ctermbg=3 ctermfg=0 
let g:neomake_warning_sign = { 
            \ 'text': 'j❯', 
            \ 'texthl': 'NeoWarningMsg', 
            \ } 

let g:neomake_open_list = 0
let g:neomake_list_height = 6 
let g:neomake_python_flake8_maker ={ 'args': ['--max-line-length=105', '--ignore=F401'], } 

let g:autopep8_max_line_length=105 
" let g:autopep8_aggressive=1 

let g:autoflake_remove_all_unused_imports=1
let g:autoflake_remove_unused_variables=1

" Stolen from chris for good ideas
"
nnoremap <C-[><C-[> :call KillLocQuick()<CR>

function! KillLocQuick()
  execute ':windo if &buftype == "quickfix" || &buftype == "locationlist" | lclose | endif'
endfunction


nnoremap <silent> ]l :try<bar>lnext<bar>catch /^Vim\%((\a\+)\)\=:E\%(553\<bar>42\):/<bar>lfirst<bar>endtry<cr>
nnoremap <silent> [l :try<bar>lnext<bar>catch /^Vim\%((\a\+)\)\=:E\%(553\<bar>42\):/<bar>lfirst<bar>endtry<cr>
noremap <Leader>l :FzfLines<CR>

let g:fzf_command_prefix = 'Fzf' 
let g:fzf_layout = { 'down': '40%' } 
autocmd VimEnter * command! Colors 
      \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'}) 

let g:autopep8_disable_show_diff=1

nnoremap <leader>d :YcmCompleter GoTo<CR>
nnoremap <leader>k :YcmCompleter GoToDefinition<CR>
nnoremap <leader>r :YcmCompleter GoToReferences<CR>

nnoremap <silent> <Leader>gd :Gdiff<CR>
nnoremap <silent> <Leader>gb :Gblame<CR>


