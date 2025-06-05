" =======================
" ===     Setup      ====
" source .env/bin/activate
" sudo steamos-readonly disable
" pip install jedi-language-server
" sudo pacman -S --needed clangd ctags base-devel
" sudo steamos-readonly activate

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
" ===       !C       ====
" compile current file
autocmd FileType c setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
nnoremap <leader>c :w<CR>:!gcc % -o %< && ./%<<CR>

" =======================
" ===      !C++      ====
autocmd FileType cpp setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
nnoremap <leader>+ :w<CR>:!g++ % -o %< && ./%<<CR>

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
    " autocmd BufWritePre *.py,*.c,*.cpp call execute('LspDocumentFormatSync')
augroup END

" =======================
" ===     Indent     ===
highlight IndentLevel0 ctermbg=233
highlight IndentLevel1 ctermbg=234
highlight IndentLevel2 ctermbg=235
highlight IndentLevel3 ctermbg=236
highlight IndentLevel4 ctermbg=237
highlight IndentLevel5 ctermbg=238
highlight IndentLevel6 ctermbg=239
highlight IndentLevel7 ctermbg=240
highlight IndentLevel8 ctermbg=241
highlight IndentLevel9 ctermbg=242
let g:indent_levels = 5
let b:indent_levels = g:indent_levels
" 0=disabled 1=enabled by default
let b:indent_enabled = 0
" remove indent highlights
function! ClearIndent()
  for i in range(0, 9)
    let l:match_var = 'w:indent_match' . i
    if exists(l:match_var) && {l:match_var} >= 1
      call matchdelete({l:match_var})
      unlet {l:match_var}
    endif
  endfor
endfunction
" indent highlight per <shiftwidth> ability
function! HighlightIndent()
  if getbufvar('%', 'indent_enabled', 0)
    call ClearIndent()
    let l:sw = &shiftwidth
    let l:levels = min([getbufvar('%', 'indent_levels', g:indent_levels), 10])
    for i in range(0, l:levels - 1)
      let l:group = 'IndentLevel' . i
      let l:match_var = 'w:indent_match' . i
      if !exists('b:indent_removed') || index(b:indent_removed, i) == -1
        let l:pattern = '^ \{'.(i*l:sw).'\}\zs \{'.l:sw.'\}\ze\S'
        let {l:match_var} = matchadd(l:group, l:pattern)
      endif
    endfor
  endif
endfunction
" toggle indent on/off for current buffer
function! ToggleIndent()
  if getbufvar('%', 'indent_enabled', 0)
    call setbufvar('%', 'indent_enabled', 0)
    call ClearIndent()
    echo "Indent disabled"
  else
    call setbufvar('%', 'indent_enabled', 1)
    call HighlightIndent()
    echo "Indent enabled"
  endif
endfunction
" set number of indents
function! SetIndent(levels)
  if a:levels >= 1 && a:levels <= 10
    call setbufvar('%', 'indent_levels', a:levels)
    call HighlightIndent()
    echo "Indent set to " . a:levels . " levels"
  else
    echohl ErrorMsg
    echo "IndentSet: Number of levels must be between 1 and 10"
    echohl None
  endif
endfunction
" reset default number of indents(5)
function! ResetIndent()
  call setbufvar('%', 'indent_levels', g:indent_levels)
  if exists('b:indent_removed')
    unlet b:indent_removed
  endif
  call HighlightIndent()
  echo "Indent reset to 5 levels"
endfunction
" remove specific indent levels
function! RemoveIndent(...)
  if a:0 == 0
    echohl ErrorMsg
    echo "IndentRemove: At least one level (1-10) required"
    echohl None
    return
  endif
  let l:removed = []
  let l:skipped = []
  if !exists('b:indent_removed')
    let b:indent_removed = []
  endif
  for level in a:000
    let l:internal_level = level - 1
    if l:internal_level >= 0 && l:internal_level <= 9
      if index(b:indent_removed, l:internal_level) == -1
        call add(b:indent_removed, l:internal_level)
        call add(l:removed, level)
      else
        call add(l:skipped, level)
      endif
    else
      echohl ErrorMsg
      echo "IndentRemove: Level " . level . " must be between 1 and 10"
      echohl None
    endif
  endfor
  if !empty(l:removed) || !empty(l:skipped)
    call HighlightIndent()
    let l:msg = ""
    if !empty(l:removed)
      let l:msg .= "Indent removed for level" . (len(l:removed) > 1 ? "s " : " ") . join(l:removed, ", ")
    endif
    if !empty(l:skipped)
      let l:msg .= (empty(l:msg) ? "" : "; ") . "Level" . (len(l:skipped) > 1 ? "s " : " ") . join(l:skipped, ", ") . " already removed"
    endif
    echo l:msg
  endif
endfunction
" add specific indent levels ability
function! AddIndent(...)
  if a:0 == 0
    echohl ErrorMsg
    echo "IndentAdd: At least one level (1-10) required"
    echohl None
    return
  endif
  let l:added = []
  let l:skipped = []
  if exists('b:indent_removed')
    for level in a:000
      let l:internal_level = level - 1
      if l:internal_level >= 0 && l:internal_level <= 9
        if index(b:indent_removed, l:internal_level) != -1
          let b:indent_removed = filter(b:indent_removed, 'v:val != ' . l:internal_level)
          call add(l:added, level)
        else
          call add(l:skipped, level)
        endif
      else
        echohl ErrorMsg
        echo "IndentAdd: Level " . level . " must be between 1 and 10"
        echohl None
      endif
    endfor
    if empty(b:indent_removed)
      unlet b:indent_removed
    endif
  else
    for level in a:000
      if level >= 1 && level <= 10
        call add(l:skipped, level)
      else
        echohl ErrorMsg
        echo "IndentAdd: Level " . level . " must be between 1 and 10"
        echohl None
      endif
    endfor
  endif
  if !empty(l:added) || !empty(l:skipped)
    call HighlightIndent()
    let l:msg = ""
    if !empty(l:added)
      let l:msg .= "Indent added for level" . (len(l:added) > 1 ? "s " : " ") . join(l:added, ", ")
    endif
    if !empty(l:skipped)
      let l:msg .= (empty(l:msg) ? "" : "; ") . "Level" . (len(l:skipped) > 1 ? "s " : " ") . join(l:skipped, ", ") . " already active"
    endif
    echo l:msg
  endif
endfunction
" help message ability
function! IndentHelp()
  echohl Title
  echo "Indent Help:"
  echohl None
  echo "     Highlight indentation levels with vertical lines"
  echo "     Uses buffer's shiftwidth (" . &shiftwidth . " spaces)"
  echo "     Enabled by default for filetypes: c, cpp, py"
  echo "     Current number of levels: " . getbufvar('%', 'indent_levels', g:indent_levels)
  echo "     Enabled: " . (getbufvar('%', 'indent_enabled', 0) ? "Yes" : "No")
  echo "     Removed levels: " . (exists('b:indent_removed') ? join(map(copy(b:indent_removed), 'v:val + 1'), ", ") : 'None')
  echohl Statement
  echo "  Indent:             - Show this help menu"
  echo "  IndentOn:           - Enable indent"
  echo "  IndentOff:          - Disable indent"
  echo "  IndentToggle:       - Toggle indent on/off"
  echo "  IndentSet <n>:      - Set number of levels (1-10)"
  echo "  IndentReset:        - Reset to default 5 levels"
  echo "  IndentRemove <n>...: - Remove coloring for level(s) (1-10)"
  echo "  IndentAdd <n>...:   - Add coloring for level(s) (1-10)"
  echohl None
endfunction
" defined commands
command! Indent call IndentHelp()
command! IndentOn call setbufvar('%', 'indent_enabled', 1) | call HighlightIndent() | echo "Indent enabled"
command! IndentOff call setbufvar('%', 'indent_enabled', 0) | call ClearIndent() | echo "Indent disabled"
command! -nargs=1 IndentSet call SetIndent(<args>)
command! IndentReset call ResetIndent()
command! -nargs=+ IndentRemove call RemoveIndent(<f-args>)
command! -nargs=+ IndentAdd call AddIndent(<f-args>)
command! IndentToggle call ToggleIndent()
" AUTO ON FOR THESE FILES:
autocmd FileType c,cpp,python call setbufvar('%', 'indent_enabled', 1) | call HighlightIndent()
" apply to all buffers
autocmd BufWinEnter * call HighlightIndent()
autocmd BufWinLeave * call ClearIndent()
autocmd OptionSet shiftwidth call HighlightIndent()

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
