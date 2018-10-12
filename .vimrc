syntax on

call plug#begin()
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/fzf',                 { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-unimpaired'
Plug 'majutsushi/tagbar'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'davidhalter/jedi-vim'
call plug#end()


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

" #au FileType js so .vim/js.vimrc
" au FileType js set shiftwidth=2
au BufRead,BufNewFile *.js so $HOME/.vim/js.vimrc
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

" autocomplete
let g:jedi#completions_command = "<C-N>"
