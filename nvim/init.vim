syntax on

set nocompatible              " required
filetype off                  " required

call plug#begin()
Plug 'vim-scripts/indentpython.vim'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Agearch for vim
Plug 'rking/ag.vim'
Plug 'tpope/vim-commentary'
Plug 'dense-analysis/ale'
Plug 'ruanyl/vim-gh-line'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'
Plug 'michaelb/sniprun'
call plug#end()            " required


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

" plug airline
let g:airline_theme='wombat'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" plug NERDTree
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '~'

" plug awesome vim colorschemes
colorscheme gruvbox

" plug coc.nvim
set updatetime=300
set signcolumn=yes
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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
set backspace=indent,eol,start
vmap <C-c> "+y

set tags=tags;/

" NERDTree
"nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
"nnoremap <C-f> :NERDTreeFind<CR>


" Linting - ALE setup
let js_fixers = ['prettier', 'eslint']

let g:ale_linters = {'python': ['flake8', 'mypy']}
let g:ale_fixers = {'python': ['black','isort'], 'javascript': js_fixers, 'javascript.jsx': js_fixers, 'typescript': js_fixers, 'typescriptreact': js_fixers }

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

cmd = f'!devx pytest --skip-db-reset {test_filename}'
if class_name:
    cmd += f'::{class_name}'
if test_name:
    cmd += f'::{test_name}'
vim.command(cmd)

EOF
endfunction

map     ;t          :call RunCurrentPythonTest()<CR>
