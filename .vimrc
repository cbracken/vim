set nocompatible
set encoding=utf-8

let s:cpo_save=&cpo
set cpo&vim

map!     <S-Insert> <MiddleMouse>
map      <S-Insert> <MiddleMouse>
inoremap jj         <ESC>
nmap     <F2>       :noh<CR>           " Clear seach highlight

let &cpo=s:cpo_save
unlet s:cpo_save

" Basic options
set incsearch                " Turn on incrememental searching
set hlsearch                 " Highlight search
set visualbell               " Less noise
set nu                       " Line numbering
set ruler                    " Show row/col in status
set showmatch                " Flash matching paren
set history=50               " 50 lines of cmdline history

" Indentation/tabulation
set autoindent
set smartindent
set ts=2
set sw=2
set softtabstop=2
set expandtab

" Colorscheme and syntax highlighting
if &t_Co > 2 || has("gui_running")
  syntax on
  set background=dark
  let g:liquidcarbon_high_contrast=1
  colorscheme liquidcarbon
  if has("gui_macvim")
    set guifont=Menlo:h14
  elseif has("unix")
    set guifont=Monospace\ 11
  endif

  if has("autocmd")
    " Highlight trailing whitespace
    highlight ExtraWhitespace ctermbg=red guibg=red
    au ColorScheme * highlight ExtraWhitespace guibg=red
    au BufEnter,InsertLeave * match ExtraWhitespace /\s\+$/
    au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/

    " Highlight over-length lines
    highlight OverLength ctermbg=red ctermfg=white guibg=#592929
    au BufEnter,InsertLeave * 2match OverLength /\%81v.\+/
    au BufEnter,InsertLeave *.java 2match OverLength /\%101v.\+/
  endif
endif

filetype plugin on

if has("autocmd")
  au BufNewFile,BufRead *.scala set filetype=scala
endif

" Other UI stuff
if has("gui_running")
  set lines=60 columns=120
  set showtabline=1          " Show tabs only if > 1 open
  set guioptions-=T          " Hide toolbar
  set guioptions-=m          " Hide menu bar

  " Menubar toggling
  :let g:toggleMenu = 0
  map <silent> <S-F1>
    \ :if g:toggleMenu == 1<CR>
    \   :set guioptions-=m<CR>
    \   :let g:toggleMenu = 0<CR>
    \ :else<CR>
    \   :set guioptions+=m<CR>
    \   :let g:toggleMenu = 1<CR>
    \ :endif<CR>
endif
