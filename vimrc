set nocompatible
set encoding=utf-8

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'cbracken/vim-one'
Plugin 'dart-lang/dart-vim-plugin'
Plugin 'fatih/vim-go'
Plugin 'fugitive.vim'
Plugin 'google/vim-ft-bzl'
Plugin 'rust-lang/rust.vim'
Plugin 'spacehi.vim'
Plugin 'vimwiki/vimwiki'
call vundle#end()
filetype plugin indent on

let mapleader=','
let s:cpo_save=&cpo
set cpo&vim

" Middle-mouse paste
map!     <S-Insert> <MiddleMouse>
map      <S-Insert> <MiddleMouse>

" Kill ex mode, map jj to ESC
noremap  Q          <NOP>
inoremap jj         <ESC>

" Kill arrow keys, for great justice
noremap  <Up>       <NOP>
noremap  <Down>     <NOP>
noremap  <Left>     <NOP>
noremap  <Right>    <NOP>

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
set showmatch                " Flash matching paren
set history=50               " 50 lines of cmdline history
set wildmenu                 " Nicer autocomplete
set wildmode=longest,full
set wildignore=*.o,*.pyc
set spelllang=en_ca

" Syntastic
let g:syntastic_mode_map = { 'mode': 'passive' }
let g:syntastic_go_checkers = ['go', 'golint']

" VimWiki
let wiki = {}
let wiki.path = '~/src/vimwiki'
let g:vimwiki_list = [wiki]

" Omnicomplete
set completeopt+=longest

" Toggle relative numbering
function! ToggleNumbering()
  if (&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
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

" Dart SDK location
let g:ycm_dart_sdk_path=$HOME.'/.dvm/darts/stable'

" Colorscheme and syntax highlighting
if &t_Co > 2 || has("gui_running")
  syntax enable
  set background=dark
  colorscheme one

  " Highlight cursor line
  set cursorline
  hi ColorColumn guibg=grey24 ctermbg=238
  hi CursorLine guibg=grey24 ctermbg=238 cterm=bold
  hi Pmenu ctermbg=grey

  if has("autocmd")
    " Cursor line highlighting
    au WinLeave * setlocal nocursorline
    au WinEnter * setlocal cursorline
    au BufLeave * setlocal nocursorline
    au BufEnter * setlocal cursorline

    " Highlight over-length lines
    au BufEnter,InsertLeave * set colorcolumn=80
    au BufEnter,InsertLeave *.java set colorcolumn=100

    " Highlight trailing space
    au BufEnter,InsertLeave *.bzl,*.c,*.cc,*.cs,*.dart,*.h,*.java,*.m,*.py,*.s SpaceHi
  endif

  if has("gui_macvim")
    set guifont=Menlo:h13
  elseif has("unix")
    set guifont=Fixed\ 10,Ricty\ 10,Source\ Code\ Pro\ 10,Monospace\ 10
  endif
endif

" Other UI stuff
if has("gui_running")
  set lines=60 columns=120
  set showtabline=1          " Show tabs only if > 1 open
  set guioptions-=T          " Hide toolbar
  set guioptions-=m          " Hide menu bar
  set guioptions+=a          " Better integration with WM selection

  " Menubar toggling
  function! ToggleMenu()
    if &go=~#'m'
      set go-=m
    else
      set go+=m
    endif
  endfunc
  map <silent> <S-F1> :call ToggleMenu()<CR>
endif
