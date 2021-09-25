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
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'majutsushi/tagbar'
" Require ctags installation.  brew install ctags
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Ag search in vim
Plugin 'rking/ag.vim'
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

" python highlight
let python_highlight_all=1
