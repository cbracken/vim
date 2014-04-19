set nocompatible
set encoding=utf-8

filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
Bundle 'blackboard.vim'
Bundle 'Dart'
Bundle 'fugitive.vim'
Bundle 'gmarik/vundle'
Bundle 'Blackrush/vim-gocode'
Bundle 'git://github.com/scala/scala-dist.git', {'rtp': 'tool-support/src/vim'}
Bundle 'Liquid-Carbon'
Bundle 'The-NERD-tree'
Bundle 'spacehi.vim'
filetype plugin indent on

let s:cpo_save=&cpo
set cpo&vim
map!     <S-Insert> <MiddleMouse>
map      <S-Insert> <MiddleMouse>
inoremap jj         <ESC>
nmap     <F2>       :noh<CR>           " Clear seach highlight
noremap  <Up>        <NOP>
noremap  <Down>      <NOP>
noremap  <Left>      <NOP>
noremap  <Right>     <NOP>
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
set ts=2
set sw=2
set softtabstop=2
set expandtab

" Whitespace highlighting
let g:spacehi_spacecolor="ctermbg=red guibg=red"
let g:spacehi_tabcolor="ctermbg=red guibg=red"
let g:spacehi_nbspcolor="ctermbg=red guibg=red"

" Colorscheme and syntax highlighting
if &t_Co > 2 || has("gui_running")
  syntax on
  set background=dark
  let g:liquidcarbon_high_contrast=1
  colorscheme liquidcarbon
  if has("gui_macvim")
    set guifont=Menlo:h11
  elseif has("unix")
    set guifont=Source\ Code\ Pro\ 11,Monospace\ 11
  endif

  if has("autocmd")
    " Highlight over-length lines
    au BufEnter,InsertLeave * set colorcolumn=80
    au BufEnter,InsertLeave *.java set colorcolumn=100
  endif
endif

" Other UI stuff
if has("gui_running")
  set lines=60 columns=120
  set showtabline=1          " Show tabs only if > 1 open
  set guioptions-=T          " Hide toolbar
  set guioptions-=m          " Hide menu bar

  " Cursor line highlighting
  autocmd WinLeave * setlocal nocursorline
  autocmd WinEnter * setlocal cursorline
  autocmd BufLeave * setlocal nocursorline
  autocmd BufEnter * setlocal cursorline
  set cursorline
  hi CursorLine guibg=#333333 cterm=none ctermbg=237

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
