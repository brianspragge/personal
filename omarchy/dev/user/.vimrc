" colorscheme zaibatsu  " pink/purple theme
silent! source ~/.config/omarchy/current/theme/vimrc

packadd! comment      " <g,c,c> or visual mode then <g,c>

set backupdir=~/.cache/vim/backup//  " list of directories for the backup file
set directory=~/.cache/vim/swap//    " list of directory names for the swap file
set tags=./tags;                     " list of file names used by the tag command
set undodir=~/.cache/vim/undo//      " where to store undo files
set undofile                         " save undo information in a file

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

set autowrite              " automatically write file if changed
set breakindent            " wrapped line repeats indent
set breakindentopt=shift:-1" settings for 'breakindent'
set showbreak=">"          " string to use at the start of wrapped lines
" set clipboard=unnamedplus  " use the clipboard as the unnamed register
set display=truncate,uhex  " list of flags for how to display text
" set expandtab              " use spaces when <Tab> is inserted
set mouse=nvi              " enable the use of mouse clicks
set mousemodel=popup_setpos" changes meaning of mouse buttons
set nowrap                 " long lines wrap and continue on the next line
set nonumber               " display the current line pos in lower right corner
set scrolloff=3            " minimum nr. of lines above and below cursor
set sidescroll=1           " minimum number of columns to scroll horizontal
set sidescrolloff=3        " min. nr. of columns to left and right of cursor

" set shiftwidth=4           " number of spaces to use for (auto)indent step
" set softtabstop=4          " number of columns between two soft tab stops
set termguicolors          " use GUI colors for the terminal
set termwinsize=8*0        " size of a terminal window
set thesaurus+=$HOME/.vim/thesaurus/english.txt
set ttimeout               " time out on mappings
set ttimeoutlen=100        " time out time for key codes in milliseconds

let mapleader = "\\"
" syntax enable

" resize windows better keybinds
nnoremap <silent> <M-j> :resize +2<CR>
nnoremap <silent> <M-k> :resize -2<CR>
nnoremap <silent> <M-h> :vertical resize +2<CR>
nnoremap <silent> <M-l> :vertical resize -2<CR>

" " Center after jumping
" nnoremap n nzt
" nnoremap N Nzt
" nnoremap * *zt
" nnoremap # #zt
" nnoremap g* g*zt
" nnoremap g# g#zt
" " Center after half-page jumps
" nnoremap <C-u> <C-u>zt
" nnoremap <C-d> <C-d>zt
" " Center after paragraph jumps
" nnoremap { {zt
" nnoremap } }zt
" " Center after jumping to bottom
" nnoremap G Gzb
" " Center after jumping prev/next positions
" nnoremap <C-i> <C-i>zz
" nnoremap <C-o> <C-o>zz

" Cycle through buffers
nnoremap <C-S-h> :bp<CR>
nnoremap <C-S-l> :bn<CR>
" Choose specific buffer
nnoremap <C-S-b> :ls<cr>:b<space>

" Align text based on '='
vnoremap <leader>= :!column -t -o = -s =<CR>

" move indent logic to ~/.vim/indent/whatever-language.vim if below is 'on'
filetype plugin indent on
" =======================
" ===     !Bash      ====
autocmd FileType sh setlocal
  \ expandtab
  \ shiftwidth=2
  \ softtabstop=-1

" =======================
" ===       !C       ====
autocmd FileType c setlocal
  \ expandtab
  \ shiftwidth=4
  \ softtabstop=-1
" split window with assembly(intel) output of current file
nnoremap <leader>a :w<CR>:!gcc -std=c11 -S -fverbose-asm -masm=intel -Wall -Wextra -Wconversion % -o /tmp/vim_temp.s<CR>:vs /tmp/vim_temp.s<CR>
" compile+run current file
nnoremap <leader>c :w<CR>:!clear; gcc -std=c11 -Wall -Wextra -Wconversion -fsanitize=address,undefined % -o %< && ./%<<CR>
" split window with assembly(intel) output of current WINDOWS file
nnoremap <leader>q :w<CR>:!x86_64-w64-mingw32-gcc -std=c11 -S -fverbose-asm -masm=intel -Wall -Wextra -Wconversion % -o /tmp/vim_temp.s<CR>:vs /tmp/vim_temp.s<CR>
" compile+run current WINDOWS file
nnoremap <leader>w :w<CR>:!clear; x86_64-w64-mingw32-gcc -std=c11 -Wall -Wextra -Wconversion % -o %< && wine %<<CR>

" =======================
" ===      !C++      ====
autocmd FileType cpp setlocal
  \ path+=/usr/include/c++/16.1.1
  \ tags+=~/.vim/tags/cpp.tags
  \ expandtab
  \ shiftwidth=2
  \ softtabstop=-1
" split window with assembly(intel) output of current file
nnoremap <leader>A :w<CR>:!gcc -std=c++17 -S -fverbose-asm -masm=intel -Wall -Wextra -Wconversion % -o /tmp/vim_temp.s<CR>:vs /tmp/vim_temp.s<CR>
" split window with assembly(intel) output of current WINDOWS file
nnoremap <leader>Q :w<CR>:!x86_64-w64-mingw32-g++ -std=c++17 -S -fverbose-asm -masm=intel -Wall -Wextra -Wconversion % -o /tmp/vim_temp.s<CR>:vs /tmp/vim_temp.s<CR>
" compile+run current WINDOWS file
nnoremap <leader>W :w<CR>:!clear; x86_64-w64-mingw32-g++ -std=c++17 -Wall -Wextra -Wconversion % -o %< && wine %<<CR>
" compile+run current file
nnoremap <leader>C :w<CR>:!clear; g++ -std=c++17 -Wall -Wextra -Wconversion -fsanitize=address,undefined % -o %< && ./%<<CR>

" =======================
" ===   JavaScript   ====
autocmd FileType javascript
  \ setlocal
  \ expandtab
  \ shiftwidth=2
  \ softtabstop=-1
" execute current file
nnoremap <leader>j :w! /tmp/vim_temp.js \| !clear; node /tmp/vim_temp.js<CR>
" execute highlighted lines in /tmp
vnoremap <leader>j :<C-U>'<,'>w! /tmp/vim_temp.js \| !clear; node /tmp/vim_temp.js<CR>

" =======================
" ===    !Python     ====
autocmd FileType python setlocal
  \ tags+=~/.vim/tags/python_stdlib.tags;~/.vim/tags/python_venv_libs.tags
  \ expandtab
  \ shiftwidth=4
  \ softtabstop=-1
" execute current file
nnoremap <leader>P :w<CR>:!clear; python %<CR>
" execute highlighted lines in /tmp
vnoremap <leader>P :<C-U>'<,'>w! /tmp/vim_temp.py \| !clear; python /tmp/vim_temp.py<CR>

" =======================
" ===     !Text      ====
"autocmd FileType text setlocal noexpandtab tabstop=5 shiftwidth=5 softtabstop=5
autocmd FileType text setlocal
  \ expandtab
  \ shiftwidth=2
  \ softtabstop=-1

" =======================
" ===     !VIM       ====
autocmd FileType vim setlocal
  \ expandtab
  \ shiftwidth=2
  \ softtabstop=-1

" =======================
" ===      Extra      ===
" thesaurus
" dictionary
" ctags
