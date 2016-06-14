set shell=/bin/bash

set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Plugin 'wikitopian/hardmode'
" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)

Plugin 'chriskempson/base16-vim'
"Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'ntpeters/vim-better-whitespace'
Bundle 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
"Plugin 'jmcantrell/vim-virtualenv'
Plugin 'majutsushi/tagbar'
Plugin 'airblade/vim-gitgutter'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
Plugin 'sirver/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plugin 'tomtom/tcomment_vim'
"Plugin 'tmhedberg/matchit'
Plugin 'jiangmiao/auto-pairs'
Plugin 'easymotion/vim-easymotion'
Plugin 'junegunn/goyo.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'Chiel92/vim-autoformat'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

map <Leader> <Plug>(easymotion-prefix)


" autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
"
" " better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

let g:pymode_rope = 0

" Use <leader>l to toggle display of whitespace
" nmap <leader>l :set list!<CR>
" " automatically change window's cwd to file's dir
set autochdir

nnoremap <silent> <C-Right> <c-w>l
nnoremap <silent> <C-Left> <c-w>h
nnoremap <silent> <C-Up> <c-w>k
nnoremap <silent> <C-Down> <c-w>j

"
" " I'm prefer spaces to tabs
set tabstop=4
set shiftwidth=4
set expandtab

" Enable folding
set foldmethod=indent
set foldlevel=99
let g:SimpylFold_docstring_preview=1

" Theming
let base16colorspace=256
colorscheme base16-chalk
set background=dark


set encoding=utf-8

let g:ycm_autoclose_preview_window_after_completion=1
" map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

syntax enable
let python_highlight_all = 1

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree


set nu

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

map <C-n> :NERDTreeToggle<CR>


" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='.a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'.a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow','#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Tagbar
nmap <F8> :TagbarToggle<CR>

hi Normal ctermbg=none
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"enable strikeythroughs and such
"" modify selected text using combining diacritics
command! -range -nargs=0 Overline        call s:CombineSelection(<line1>, <line2>, '0305')
command! -range -nargs=0 Underline       call s:CombineSelection(<line1>, <line2>, '0332')
command! -range -nargs=0 DoubleUnderline call s:CombineSelection(<line1>, <line2>, '0333')
command! -range -nargs=0 Strikethrough   call s:CombineSelection(<line1>, <line2>, '0336')

function! s:CombineSelection(line1, line2, cp)
	  execute 'let char = "\u'.a:cp.'"'
	    execute a:line1.','.a:line2.'s/\%V[^[:cntrl:]]/&'.char.'/ge'
    endfunction

" Connect clipboards
"set clipboard=unnamed
map <C-c> "+y<CR>"
set clipboard=unnamedplus

let g:SuperTabCrMapping=1

" Habit breaking time
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>


"double tap i to escape
imap ii <Esc>
autocmd BufWritePre *.py :%s/\s\+$//e
autocmd BufWritePre *.cc :%s/\s\+$//e

set undofile
set undodir=~/.vimundo/
set relativenumber
set number

autocmd BufRead,BufNewFile *.md setlocal spell

