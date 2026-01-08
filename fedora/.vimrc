" =======================
" ===    Settings    ====
colorscheme zaibatsu  " pink/purple theme

set backupdir=~/.cache/vim/backup//  " list of directories for the backup file
set directory=~/.cache/vim/swap//    " list of directory names for the swap file

" suffixes that are ignored with multiple match
set suffixes=.bak,~,.o,.info,.swp,.aux,.bbl,.blg,.brf,.cb,.dvi,.idx,.ilg,.ind
set suffixes+=.inx,.jpg,.log,.out,.png,.toc

" files matching these patterns are not completed
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/node_modules/*,*/dist/*,*/build/*
set wildignore+=*/coverage/*,*/__pycache__/*,*.o,*.obj,*.pyc,*.pyo,*.exe,*.dll
set wildignore+=*.so,*.zip,*.tar.gz,*.tar.bz2,*.rar,*.min.js,*.min.css,*.log
set wildignore+=*.tmp,*.swp,*.swo,*.DS_Store
set wildmenu                    " use menu for command line completion
set wildmode=longest:full,full  " mode for 'wildchar' command-line expansion

set display=truncate,uhex  " list of flags for how to display text
set expandtab              " use spaces when <Tab> is inserted
set mouse=a                " enable the use of mouse clicks
set number                 " display the current line pos in lower right corner
set scrolloff=999          " minimum nr. of lines above and below cursor
set shiftwidth=4           " number of spaces to use for (auto)indent step
set softtabstop=4          " number of columns between two soft tab stops
set termguicolors          " use GUI colors for the terminal
set termwinsize=8*0        " size of a terminal window
set ttimeout               " time out on mappings
set ttimeoutlen=100        " time out time for key codes in milliseconds

" resize windows better keybinds
nnoremap <silent> <M-j> :resize +2<CR>
nnoremap <silent> <M-k> :resize -2<CR>
nnoremap <silent> <M-h> :vertical resize +2<CR>
nnoremap <silent> <M-l> :vertical resize -2<CR>

" move indent logic to ~/.vim/indent/whatever-language.vim if below is 'on'
filetype plugin indent on
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
set tags=./tags;~/tags/python_stdlib.tags;~/tags/python_venv_libs.tags
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
