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
set expandtab
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
set scrolloff=5
set shiftwidth=4
set showcmd
set suffixes=.bak,~,.o,.info,.swp,.aux,.bbl,.blg,.brf,.cb,.dvi,.idx,.ilg,.ind,.inx,.jpg,.log,.out,.png,.toc
set ttimeout
set ttimeoutlen=100
set undodir=~/.cache/vim/undo//
set wildmenu
syntax on
" vim: set filetype=vim :

" =======================
" ===      Ruler      ===
let g:ruler_place = 79
if !exists('b:ruler_column')
  let b:ruler_column = g:ruler_place
endif
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
