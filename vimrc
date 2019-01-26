set nocompatible
set encoding=utf-8

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'spacehi.vim'                " Highlight bad whitespace

" Language support
Plugin 'dart-lang/dart-vim-plugin'
Plugin 'fatih/vim-go'
Plugin 'keith/swift.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'google/vim-ft-bzl'
call vundle#end()
filetype plugin indent on

" Bind fancier manpage plugin to Shift-k
runtime ftplugin/man.vim
set keywordprg=:Man

let mapleader=','
let s:cpo_save=&cpo
set cpo&vim

" Middle-mouse paste
map!     <S-Insert> <MiddleMouse>
map      <S-Insert> <MiddleMouse>

" Kill ex mode
noremap  Q          <NOP>

" Kill arrow keys, for great justice
noremap  <Up>       <NOP>
noremap  <Down>     <NOP>
noremap  <Left>     <NOP>
noremap  <Right>    <NOP>

" Map clang-format
map  <C-K>      :call ClangFormat()<cr>
imap <C-K> <ESC>:call ClangFormat()<cr>

function ClangFormat()
  let l:line_start = getpos("'<")[1]
  let l:line_end = getpos("'>")[1]
  let l:lines = "all"
  if l:line_start != 0 && l:line_end != 0
    let l:lines = l:line_start . ":" . l:line_end
  endif
  py3f ~/share/clang/clang-format.py
endfunction

" Retain selection on <,>
vmap     < <gv
vmap     > >gv
let &cpo=s:cpo_save
unlet s:cpo_save

" Basic options
set incsearch                " Turn on incrememental searching
set hlsearch                 " Highlight search
set visualbell               " Less noise
set number                   " Relative line numbering
set ruler                    " Show row/col in status
set laststatus=1             " Only show status line if > 1 window
set showmatch                " Flash matching paren
set history=50               " 50 lines of cmdline history
set wildmenu                 " Nicer autocomplete
set wildmode=longest,full
set wildignore=*.o,*.pyc
set spelllang=en_ca

" Omnicomplete
set completeopt+=longest

" Toggle relative numbering
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

" Indentation/tabulation
set autoindent
set smartindent
set smarttab
set ts=2
set sw=2
set softtabstop=2
set expandtab

" Fix python's indent overrides
au FileType python setl ts=2 sw=2 sts=2 et

" Whitespace highlighting
let g:spacehi_spacecolor="ctermbg=red guibg=red"
let g:spacehi_tabcolor="ctermbg=red guibg=red"
let g:spacehi_nbspcolor="ctermbg=red guibg=red"

" Golang
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:syntastic_go_checkers = ["go", "golint", "errcheck"]

" Colorscheme and syntax highlighting
if &t_Co > 2
  syntax enable
  set background=dark

  " No background colour in terminal
  hi Normal ctermbg=none

  " Visual selection colour
  hi Visual ctermbg=237

  " Spelling mistake hightlight colour
  hi SpellLocal cterm=underline ctermbg=58
  hi SpellBad cterm=underline ctermbg=88

  " Completion menu colour
  hi Pmenu ctermbg=0 ctermfg=8
  hi PmenuSel ctermbg=8 ctermfg=15

  " Highlight cursor line, max column
  set cursorline
  hi ColorColumn guibg=grey24 ctermbg=235
  hi CursorLine guibg=grey24 ctermbg=235 cterm=bold

  " Line numbers
  hi LineNr ctermfg=7
  hi CursorLineNr ctermfg=15

  if has("autocmd")
    " Cursor line highlighting
    au WinLeave * setlocal nocursorline
    au WinEnter * setlocal cursorline
    au BufLeave * setlocal nocursorline
    au BufEnter * setlocal cursorline

    " Highlight over-length lines
    au BufEnter,InsertLeave * set colorcolumn=80
    au BufEnter,InsertLeave *.java,*.m,*.mm set colorcolumn=100
    au BufEnter,InsertLeave *.java,*.m,*.mm set textwidth=100

    " Highlight trailing space
    au BufEnter,InsertLeave *.bzl,*.c,*.cc,*.cs,*.dart,*.h,*.java,*.m,*.mm,*.py,*.s SpaceHi
  endif
endif
