" =======================
" ===    Settings    ====
version 9.1
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
inoremap <C-U> u
nmap Q gq
xmap Q gq
omap Q gq
xmap gx <Plug>NetrwBrowseXVis
nmap gx <Plug>NetrwBrowseX
xnoremap <silent> <Plug>NetrwBrowseXVis :call netrw#BrowseXVis()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#BrowseX(netrw#GX(),netrw#CheckIfRemote(netrw#GX()))
nnoremap <silent> <M-j> :resize +2<CR>
nnoremap <silent> <M-k> :resize -2<CR>
nnoremap <silent> <M-h> :vertical resize +2<CR>
nnoremap <silent> <M-l> :vertical resize -2<CR>
inoremap  u
let &cpo=s:cpo_save
unlet s:cpo_save
"set background=light
set backspace=indent,eol,start
set backupdir=~/.cache/vim/backup//
set directory=~/.cache/vim/swap//
set display=truncate
set expandtab  " Tab to spaces
set fileencodings=ucs-bom,utf-8,default,latin1
set helplang=en
set history=200
set incsearch
set langnoremap
set langremap
set mouse=a
set nrformats=bin,hex
set number
set ruler
set tabstop=4
set tags=./tags;~/tags/python_stdlib.tags;~/tags/python_venv_libs.tags
" set termguicolors
set scrolloff=5
set shiftwidth=4  " Tab width 
set showcmd
set softtabstop=4  " Insert mode
set suffixes=.bak,~,.o,.info,.swp,.aux,.bbl,.blg,.brf,.cb,.dvi,.idx,.ilg,.ind,.inx,.jpg,.log,.out,.png,.toc
set ttimeout
set ttimeoutlen=100
set undodir=~/.cache/vim/undo//
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/node_modules/*,*/dist/*,*/build/*,*/coverage/*,*/__pycache__/*
set wildignore+=*.o,*.obj,*.pyc,*.pyo,*.exe,*.dll,*.so,*.zip,*.tar.gz,*.tar.bz2,*.rar,*.min.js,*.min.css
set wildignore+=*.log,*.tmp,*.swp,*.swo,*.DS_Store
set wildmenu
set wildmode=longest:full,full
syntax on
filetype plugin indent on
" vim: set filetype=vim :

" =======================
" ===     !Bash      ====
autocmd FileType sh setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

" =======================
" ===       !C       ====
" compile current file
autocmd FileType c setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
vnoremap <leader>c :w<CR>:!gcc -std=c99 % -o %< && ./%<<CR>

" =======================
" ===      !C++      ====
autocmd FileType cpp setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
vnoremap <leader>+ :w<CR>:!g++ % -o %< && ./%<<CR>

" =======================
" ===    !Python     ====
let mapleader = "\\"
autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
" execute highlighted code in new terminal buffer
vnoremap <leader>p :<C-U>'<,'>w! /tmp/vim_temp.py \| !clear; python /tmp/vim_temp.py<CR>

" =======================
" ===     !Text      ====
autocmd FileType text setlocal noexpandtab tabstop=5 shiftwidth=5 softtabstop=5

" =======================
" ===      Extra      ===
" :help thesaurus
