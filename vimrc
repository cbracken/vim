set nocompatible
set encoding=utf-8

" Remove any autocmds defined by the system for consistency.
if has("autocmd")
  autocmd!
endif

call plug#begin('~/.vim/plugged')
Plug 'rhysd/vim-clang-format'   " clang-format.
Plug 'vim-scripts/spacehi.vim'  " Highlight bad whitespace.

" Language support plugins.
Plug 'cespare/vim-toml'
Plug 'dart-lang/dart-vim-plugin'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'google/vim-ft-bzl'
Plug 'keith/swift.vim'
Plug 'rust-lang/rust.vim'
Plug 'https://gn.googlesource.com/gn', { 'rtp': 'misc/vim' }
call plug#end()

" Bind fancier manpage plugin to Shift-k.
runtime ftplugin/man.vim
set keywordprg=:Man

let mapleader=','
let s:cpo_save=&cpo
set cpo&vim

" Enable middle-mouse paste.
map!     <S-Insert> <MiddleMouse>
map      <S-Insert> <MiddleMouse>

" Kill ex mode.
noremap  Q          <NOP>

" Disable visual-mode mouse select.
set mouse=

" Kill arrow keys, for great justice.
noremap  <Up>       <NOP>
noremap  <Down>     <NOP>
noremap  <Left>     <NOP>
noremap  <Right>    <NOP>

" Retain selection on <,>.
vmap     < <gv
vmap     > >gv
let &cpo=s:cpo_save
unlet s:cpo_save

" Basic options
set incsearch                " Turn on incrememental searching.
set hlsearch                 " Highlight search.
set visualbell               " Less noise.
set number                   " Use line numbering.
set ruler                    " Show row/col in status.
set laststatus=1             " Only show status line if > 1 window.
set showmatch                " Highlight matching bracket.
set history=50               " Keep 50 lines of cmdline history.
set wildmenu                 " Nicer autocomplete.
set wildmode=longest,full
set wildignore=*.o,*.pyc     " Ignore some filetypes during completion.
set spelllang=en_ca          " Set the spelling language.

" Omnicomplete
set completeopt+=longest

" Indentation/tabulation
set autoindent      " Copy indent from current line when starting a new line.
set smartindent     " Attempt to autoindent when starting a new line.
set smarttab        " Use shiftwidth rather than tabstop at start of line.
set tabstop=2       " Number of spaces per tab.
set shiftwidth=2    " Number of spaces for each step of autoindent.
set softtabstop=2   " Number of spaces per tab when editing.
set expandtab       " Insert spaces in place of tabs.

" Configure whitespace highlighting.
let g:spacehi_spacecolor="ctermbg=red guibg=red"
let g:spacehi_tabcolor="ctermbg=red guibg=red"

" Configure tag file locations.
set tags+=~/.local/tags/system.tags
set tags+=~/.local/tags/cxx.tags

" Configure golang support.
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:syntastic_go_checkers = ["go", "golint", "errcheck"]

" Snippets
nmap <leader>sch :0r ~/.vim/snippets/cc.h<CR>
nmap <leader>sci :0r ~/.vim/snippets/cc.cc<CR>
nmap <leader>scn :.-1r ~/.vim/snippets/namespace.cc<CR>
nmap <leader>scs :.-1r ~/.vim/snippets/struct.cc<CR>
nmap <leader>scc :.-1r ~/.vim/snippets/class.cc<CR>
nmap <leader>sjn :.-1r ~/.vim/snippets/journal.md<CR>

" Configure colour scheme and syntax highlighting.
if &t_Co > 2
  syntax enable
  set background=dark

  " No background colour in terminal.
  hi Normal ctermbg=none

  " Visual selection colour.
  hi Visual ctermbg=237

  " Spelling mistake hightlight colour.
  hi SpellLocal cterm=underline ctermbg=58
  hi SpellBad cterm=underline ctermbg=88

  " Completion menu colour.
  hi Pmenu ctermbg=0 ctermfg=8
  hi PmenuSel ctermbg=8 ctermfg=15

  " Line number colour.
  hi LineNr ctermfg=7

  " Highlight cursor line, max column.
  set cursorline
  hi ColorColumn guibg=grey24 ctermbg=235
  hi CursorLine guibg=grey24 ctermbg=235 cterm=bold
  hi CursorLineNr ctermbg=235 cterm=bold

  if has("autocmd")
    " Cursor line highlighting
    au WinLeave * setlocal nocursorline
    au WinEnter * setlocal cursorline
    au BufLeave * setlocal nocursorline
    au BufEnter * setlocal cursorline

    " Highlight over-length lines
    au BufEnter,InsertLeave * set colorcolumn=80
    au BufEnter,InsertLeave *.txt,*.md,*.wiki set colorcolumn=80
    au BufEnter,InsertLeave *.txt,*.md,*.wiki set textwidth=80
    au BufEnter,InsertLeave *.java,*.m,*.mm set colorcolumn=100
    au BufEnter,InsertLeave *.java,*.m,*.mm set textwidth=100

    " Highlight trailing space
    au BufEnter,InsertLeave *.bzl,*.c,*.cc,*.cpp,*.cs,*.dart,*.h,*.java,*.m,*.mm,*.py,*.s SpaceHi

    " Fix python's indent overrides.
    au FileType python setl ts=2 sw=2 sts=2 et
  endif
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functions

" Apply clang-format to a range of lines (or all).
function ClangFormat()
  let l:line_start = getpos("'<")[1]
  let l:line_end = getpos("'>")[1]
  let l:lines = "all"
  if l:line_start != 0 && l:line_end != 0
    let l:lines = l:line_start . ":" . l:line_end
  endif
  py3f ~/share/clang/clang-format.py
endfunction
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>

" Toggle absolute/relative numbering.
function! ToggleNumbering()
  if (&number == 0)
    set number
  elseif (&relativenumber == 0)
    set relativenumber
  else
    set norelativenumber
    set nonumber
  endif
endfunc
nmap <C-n> :call ToggleNumbering()<CR>
