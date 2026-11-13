" colorscheme zaibatsu  " pink/purple theme
packadd! comment        " <g,c,c> or visual mode then <g,c>
packadd! editorconfig   " Loads parent directory .editorconfig file for default
                        " syntax rules
packadd! hlyank         " This package briefly highlights the affected region of
                        " the last yank command
packadd! termdebug      " :Termdebug <file>

" =======================
" ===    Settings    ====
" =======================
set backupdir=~/.cache/vim/backup//  " list of directories for the backup file
set directory=~/.cache/vim/swap//    " list of directory names for the swap file
set tags=./tags;                     " list of file names used by the tag command
set path+=**                         " list of directories searched with "gf" et.al.
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

" (UNTESTED): Switch CWD to the directory of the open buffer
" map <leader>cd :cd %:p:h<cr>:pwd<cr>
set autochdir              " change directory to the file in the current window
" set autowrite              " automatically write file if changed
set autoindent             " take indent for new line from previous line
set breakindent            " wrapped line repeats indent (see 'showbreak')
set breakindentopt=shift:-2 " settings for 'breakindent'
set cpoptions+=n           " flags for Vi-compatible behavior
set cursorline             " highlight the screen line of the cursor
" set clipboard=unnamedplus  " use the clipboard as the unnamed register
set display=truncate,uhex  " list of flags for how to display text
set hlsearch               " highlight matches with last search pattern
set incsearch              " highlight match while typing search pattern
" set expandtab              " use spaces when <Tab> is inserted
set mouse=nvi              " enable the use of mouse clicks
set mousemodel=popup_setpos " changes meaning of mouse buttons
set wrap                   " long lines wrap and continue on the next line
set nonumber               " display the current line pos in lower right corner
set norelativenumber       " show relative line number in front of each line
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
set visualbell             " use visual bell instead of beeping
set nowrapscan             " searches wrap around the end of the file

let &showbreak = '> '      " string to use at the start of wrapped lines

let mapleader = "\\"
syntax enable
filetype plugin indent on

" resize windows better keybinds
nnoremap <silent> <M-j> :resize +2<CR>
nnoremap <silent> <M-k> :resize -2<CR>
nnoremap <silent> <M-h> :vertical resize +2<CR>
nnoremap <silent> <M-l> :vertical resize -2<CR>

" " Center after jumping
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
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

" Choose specific buffer with <:ls b>, <your number choice>, <Enter>
" Cycle through buffers
nnoremap <C-h> :bp<CR>
nnoremap <C-l> :bn<CR>

" Align text based on ' '
vnoremap <leader><space> :!column -t -o ' ' -s ' '<CR>
" Align text based on '='
vnoremap <leader>= :!column -t -o = -s =<CR>

" move indent logic to ~/.vim/indent/whatever-language.vim if below is 'on'
filetype plugin indent on

" =======================
" ===      !ASM      ====
autocmd FileType asm setlocal
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
" compile with debug symbols but don't run
nnoremap <leader>d :w<CR>:!clear; gcc -g -std=c11 -Wall -Wextra -Wconversion -fsanitize=address,undefined % -o %<<CR>
" split window with assembly(intel) output of current WINDOWS file
nnoremap <leader>q :w<CR>:!x86_64-w64-mingw32-gcc -std=c11 -S -fverbose-asm -masm=intel -Wall -Wextra -Wconversion % -o /tmp/vim_temp.s<CR>:vs /tmp/vim_temp.s<CR>
" compile+run current WINDOWS file
nnoremap <leader>w :w<CR>:!clear; x86_64-w64-mingw32-gcc -std=c11 -Wall -Wextra -Wconversion % -o %< && wine %<<CR>

" =======================
" ===      !C++      ====
autocmd FileType cpp setlocal
  \ tags+=~/.vim/tags/cpp.tags
  \ expandtab
  \ shiftwidth=2
  \ softtabstop=-1
  \ cinoptions+=g1,h1
" split window with assembly(intel) output of current file
nnoremap <leader>A :w<CR>:!gcc -std=c++17 -S -fverbose-asm -masm=intel -Wall -Wextra -Wconversion % -o /tmp/vim_temp.s<CR>:vs /tmp/vim_temp.s<CR>
" split window with assembly(intel) output of current WINDOWS file
nnoremap <leader>Q :w<CR>:!x86_64-w64-mingw32-g++ -std=c++17 -S -fverbose-asm -masm=intel -Wall -Wextra -Wconversion % -o /tmp/vim_temp.s<CR>:vs /tmp/vim_temp.s<CR>
" compile+run current WINDOWS file
nnoremap <leader>W :w<CR>:!clear; x86_64-w64-mingw32-g++ -std=c++17 -Wall -Wextra -Wconversion % -o %< && wine %<<CR>
" compile+run current file
nnoremap <leader>C :w<CR>:!clear; g++ -std=c++17 -Wall -Wextra -Wconversion -fsanitize=address,undefined % -o %< && ./%<<CR>
" compile with debug symbols but don't run
nnoremap <leader>D :w<CR>:!clear; g++ -g -std=c++17 -Wall -Wextra -Wconversion -fsanitize=address,undefined % -o %<<CR>

" =======================
" ===      !Go       ====
autocmd FileType go setlocal
  \ tags+=~/.vim/tags/go_stdlib.tags
  \ noexpandtab
  \ tabstop=2
" function to auto format right before saving file/buffer
function! GoLangFormatOnSave()
  let view = winsaveview()
  silent! %!gofmt
  if v:shell_error
    silent undo
  endif
  call winrestview(view)
endfunction
autocmd BufWritePre *.go call GoLangFormatOnSave()
" execute current file
nnoremap <leader>g :w<CR>:!clear; go run '%'<CR>
nnoremap <leader>G :w<CR>:!clear; go test *.go -v<CR>

" =======================
" ===  !JavaScript   ====
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
" ===     !Rust      ====
autocmd FileType rust setlocal
  \ tags+=~/.vim/tags/rust_stdlib.tags
  \ expandtab
  \ shiftwidth=2
  \ softtabstop=-1

" =======================
" ===     !Text      ====
"autocmd FileType text setlocal noexpandtab tabstop=5 shiftwidth=5 softtabstop=5
autocmd FileType text setlocal
  \ expandtab
  \ shiftwidth=2
  \ softtabstop=-1

" =======================
" ===  !Typescript   ====
autocmd FileType typescript setlocal
  \ expandtab
  \ shiftwidth=2
  \ softtabstop=-1
" execute current file
nnoremap <leader>t :w<CR>:!clear; ts-node %<CR>
" execute highlighted lines in /tmp
vnoremap <leader>t :<C-U>'<,'>w! /tmp/vim_temp.ts \| !clear; ts-node /tmp/vim_temp.ts<CR>

" =======================
" ===  !Type/React   ====
autocmd FileType typescriptreact setlocal
  \ expandtab
  \ shiftwidth=2
  \ softtabstop=-1
" execute current file
nnoremap <leader>T :w<CR>:!clear; yarn ts-node %<CR>
" execute highlighted lines in /tmp
vnoremap <leader>T :<C-U>'<,'>w! /tmp/vim_temp.tsx \| !clear; yarn ts-node /tmp/vim_temp.tsx<CR>

" =======================
" ===     !VIM       ====
autocmd FileType vim setlocal
  \ expandtab
  \ shiftwidth=2
  \ softtabstop=-1

" =======================
" ===    Plugins     ====
" =======================
call plug#begin('~/.vim/plugged')
" List plugins here:
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/vim-lsp'
call plug#end()
" asyncomplete settings
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_hover = 1
let g:asyncomplete_sources = ['vim-lsp']
set completeopt=menuone,noinsert,noselect,preview
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
" lsp server
if executable('jedi-language-server')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'jedi',
        \ 'cmd': {server_info->['jedi-language-server']},
        \ 'allowlist': ['python'],
        \ })
endif
if executable('clangd')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'allowlist': ['c', 'objc', 'cpp', 'objcpp'],
        \ })
endif
if executable('bash-language-server')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'bash',
        \ 'cmd': {server_info->['bash-language-server', 'start']},
        \ 'allowlist': ['sh', 'bash'],
        \ })
endif
" vim-lsp settings
noremap <leader>f :LspDocumentFormat<CR>
function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
  nmap <buffer> gd <plug>(lsp-definition)
  let g:lsp_format_sync_timeout = 1000
endfunction
augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
  " autocmd BufWritePre *.py,*.c,*.cpp call execute('LspDocumentFormatSync')
augroup END

" =======================
" ===      Ruler      ===
" =======================
let g:ruler_place = 79
let b:ruler_column = g:ruler_place
highlight Ruler ctermbg=yellow ctermfg=black
" remove match if exists
function! ClearRuler()
  if exists('w:ruler_match') && w:ruler_match >= 1
    call matchdelete(w:ruler_match)
    unlet w:ruler_match
  endif
endfunction
" highlight ruler per buffer
function! HighlightRuler()
  call ClearRuler()
  let l:col = getbufvar('%', 'ruler_column', g:ruler_place)
  let l:pattern = '\%>' . l:col . 'v.\+'
  let w:ruler_match = matchadd('Ruler', l:pattern)
endfunction
" toggle ruler ability
function! ToggleRuler()
  if exists('w:ruler_match')
    call ClearRuler()
  else
    call HighlightRuler()
  endif
endfunction
" set ruler placement per column ability
function! SetRuler(column)
  let b:ruler_column = a:column
  call HighlightRuler()
endfunction
" reset ruler column to default ability
function! ResetRuler()
  let b:ruler_column = g:ruler_place
  call HighlightRuler()
endfunction
" help message ability
function! RulerHelp()
  echohl Title
  echo "Ruler Help:"
  echohl None
  echo "     Highlight text beyond the set amount: " . b:ruler_column . ""
  echohl Statement
  echo "  Ruler:         - Show this help menu"
  echo "  RulerOn:       - Enable the Ruler"
  echo "  RulerOff:      - Disable the Ruler"
  echo "  RulerSet <n>:  - Sets the ruler placement to <n>"
  echo "  RulerReset:    - Reset placement to default: " . g:ruler_place . ""
  echo "  RulerToggle:   - Toggle the Ruler on/off"
  echohl None
endfunction
" defined commands
command! Ruler call RulerHelp()
command! RulerOn call HighlightRuler()
command! RulerOff call ClearRuler()
command! -nargs=1 RulerSet call SetRuler(<args>)
command! RulerReset call ResetRuler()
command! RulerToggle call ToggleRuler()
" apply to all buffers
autocmd BufWinEnter * call HighlightRuler()
autocmd BufWinLeave * call ClearRuler()

" =======================
" ===      Extra      ===
" :help thesaurus
