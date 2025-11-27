" =======================
" ===     Setup      ====
" Use vim.sh from repo personal/dev/setup/
packadd! comment        " <g,c,c> or visual mode then <g,c>
packadd! termdebug      " :Termdebug <file>

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
set termguicolors
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

"" =======================
"" ===     Indent      ===
"highlight IndentGuide ctermfg=245
"let g:indent_levels = 5
"set conceallevel=1
"" define highlight groups
"for i in range(0, g:indent_levels)
"  execute 'highlight default link IndentLevel' . i . ' IndentGuide'
"endfor
"" clear previous indent matches
"function! ClearIndent() abort
"  for i in range(0, g:indent_levels)
"    let varbase = 'indent_match' . i
"    if exists('w:' . varbase)
"      call matchdelete(get(w:, varbase))
"      execute 'unlet w:' . varbase
"    endif
"  endfor
"endfunction
"" toggle function
"function! ToggleIndent() abort
"  if getbufvar('%', 'indent_enabled', 0)
"    call setbufvar('%', 'indent_enabled', 0)
"    call ClearIndent()
"    echo "Indent disabled"
"  else
"    call setbufvar('%', 'indent_enabled', 1)
"    call HighlightIndent()
"    echo "Indent enabled"
"  endif
"endfunction
"" indent highlight per <shiftwidth> or tab ability
"function! HighlightIndent()
"  if getbufvar('%', 'indent_enabled', 0)
"    call ClearIndent()
"    let l:sw = &shiftwidth
"    let l:ts = &tabstop
"    let l:et = &expandtab
"    if l:sw == 0 | return | endif
"    let l:conceal = '┊'
"    for i in range(1, g:indent_levels)
"      let l:group = 'IndentLevel' . (i - 1)
"      let l:varbase = 'indent_match' . (i - 1)
"      if !exists('b:indent_removed') || index(b:indent_removed, i - 1) == -1
"        if l:et
"          let l:pattern = '^' . repeat('\%(' . repeat(' ', l:sw) . '\)', i)
"        else
"          let l:pattern = '^' . repeat('\t', i)
"        endif
"        execute 'let w:' . l:varbase . ' = matchadd("' . l:group . '", "' . l:pattern . '", 10, -1, {"conceal":"' . l:conceal . '"})'
"      endif
"    endfor
"  endif
"endfunction
"" help message
"function! IndentHelp() abort
"  echohl Title
"  echo "Indent Guide Help:"
"  echohl None
"  echo "  • Uses ┊ as indent guide."
"  echo "  • Enabled = " . (getbufvar('%', 'indent_enabled', 0) ? "Yes" : "No")
"  echohl Statement
"  echo "Commands:"
"  echo "  :Indent        – This help menu"
"  echo "  :IndentOn      – Enable for this buffer"
"  echo "  :IndentOff     – Disable for this buffer"
"  echo "  :IndentToggle  – Toggle on/off"
"  echohl None
"endfunction
"" define commands
"command! Indent       call IndentHelp()
"command! IndentOn     call setbufvar('%', 'indent_enabled', 1) | call HighlightIndent() | echo "Indent enabled"
"command! IndentOff    call setbufvar('%', 'indent_enabled', 0) | call ClearIndent()  | echo "Indent disabled"
"command! IndentToggle call ToggleIndent()
"" auto-enable for certain filetypes
"autocmd FileType c,cpp,python call setbufvar('%', 'indent_enabled', 1) | call HighlightIndent()
"" refresh on WinEnter/Leave
"autocmd BufWinEnter * if getbufvar('%', 'indent_enabled', 0) | call HighlightIndent() | endif
"autocmd BufWinLeave * if getbufvar('%', 'indent_enabled', 0) | call ClearIndent()    | endif
"" Re-highlight when shiftwidth changes
"autocmd OptionSet shiftwidth if getbufvar('%', 'indent_enabled', 0) | call HighlightIndent() | endif
"

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
" :help thesaurus

