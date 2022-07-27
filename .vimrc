syntax on

set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'vim-scripts/indentpython.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'majutsushi/tagbar'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Ag search for vim
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-commentary'
Plugin 'dense-analysis/ale'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'ruanyl/vim-gh-line'
" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)
" ...

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" searching
set ignorecase
set smartcase
set hls

" indenting
" I have a love-hate relationship with AI/SI... if only it really chilled out during pastes
filetype indent on
set ai
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set number
set laststatus=2

" auto reload .vimrc
augroup VIMRC_AUTO_RELOAD
    autocmd!
    autocmd bufwritepost $MYVIMRC source $MYVIMRC
augroup end

" hit f2 to fix autoindent-during-paste
nnoremap <c-p> :set invpaste paste?<CR>
set pastetoggle=<c-p>
set showmode

" Set plugin / syntax required options...
set nocompatible
filetype plugin on

" Set personalized key settings...
let mapleader=","
nnoremap <F3> :let @/ = ""<CR>
set whichwrap+=<,>,h,l,[,]

" Colors
"set background=dark

if $BIGTERM
    "colorscheme zenburn
    colorscheme wombat256
endif

" au FileType js set shiftwidth=2
au BufRead,BufNewFile *.coffee so $HOME/.vim/coffee.vimrc
au BufRead,BufNewFile *.scss so $HOME/.vim/scss.vimrc

set runtimepath^=~/.vim/bundle/ctrlp.vim

" http://kien.github.io/ctrlp.vim/#installation
" If we have The Silver Searche
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor
    " Use ag in CtrlP for listing files. Lightning fast and respects
   let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
   let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

   " ag is fast enough that CtrlP doesn't need to cache
   let g:ctrlp_use_caching = 0
endif

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set runtimepath^=~/.vim/bundle/ctrlp.vim

" tagbar shortcut
nmap <silent> <C-t> :TagbarToggle<CR>
vmap " :w !pbcopy<CR><CR>

" Linting - ALE setup
let js_fixers = ['prettier', 'eslint']

let g:ale_linters = {'python': ['flake8', 'mypy']}
let g:ale_fixers = {'python': ['black','isort'], 'javascript': js_fixers, 'javascript.jsx': js_fixers, 'typescript': js_fixers, 'typescriptreact': js_fixers }
" auto linter fix on save
let g:ale_fix_on_save=1

" Auto run a specific pytest
function! RunCurrentPythonTest()
python3 << EOF

import re
import vim  # https://vimhelp.org/if_pyth.txt.html

cursor = vim.current.window.cursor
test_filename = vim.eval("expand('%p')")

test_name = None
class_name = None
for line_no in range(cursor[0]-1, -1, -1):
    line = vim.current.buffer[line_no]
    if not test_name and line.lstrip().startswith('def test'):
        test_name = re.findall('def (\w+)\(', line)[0]
    if not class_name and line.startswith('class'):
        class_name = re.findall('class (\w+)\(', line)[0]
        break

cmd = f'!pytest {test_filename}'
if class_name:
    cmd += f'::{class_name}'
if test_name:
    cmd += f'::{test_name}'
vim.command(cmd)

EOF
endfunction

map     ;t          :call RunCurrentPythonTest()<CR>
