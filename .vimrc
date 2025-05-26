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
inoremap <C-e> <Esc> 
inoremap  u
let &cpo=s:cpo_save
unlet s:cpo_save
set background=dark
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
" ===      !gcc      ====
" compile current file
autocmd FileType c setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
nnoremap <leader>c :w<CR>:!gcc % -o %< && ./%<<CR>

" =======================
" ===      !g++      ====
autocmd FileType cpp setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
nnoremap <leader>+ :w<CR>:!g++ % -o %< && ./%<<CR>

" =======================
" ===      !py       ====
let mapleader = "\\"
autocmd FileType py setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
" execute highlighted code in new terminal buffer
vnoremap <leader>p :<C-U>'<,'>w! /tmp/vim_temp.py \| !clear; python /tmp/vim_temp.py<CR>

" =======================
" ===     !text      ====
autocmd FileType text setlocal noexpandtab tabstop=5 shiftwidth=5 softtabstop=5

" =======================
" ===    Plugins     ====
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
    autocmd BufWritePre *.py,*.c,*.cpp call execute('LspDocumentFormatSync')
augroup END

" =======================
" ===      Ruler      ===
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
