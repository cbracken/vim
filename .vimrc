set nocompatible
set encoding=utf-8

let s:cpo_save=&cpo
set cpo&vim

map! <S-Insert> <MiddleMouse>
map  <S-Insert> <MiddleMouse>
nmap <F2> :noh<CR>           " Clear seach highlight

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
  colorscheme blackboard
  set guifont=Menlo:h12

  " Highlight trailing whitespace
  if has("autocmd")
    highlight ExtraWhitespace ctermbg=red guibg=red
    au ColorScheme * highlight ExtraWhitespace guibg=red
    au BufEnter * match ExtraWhitespace /\s\+$/
    au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    au InsertLeave * match ExtraWhiteSpace /\s\+$/
  endif
endif

filetype plugin on

if has("autocmd")
  au BufNewFile,BufRead *.scala set filetype=scala
endif

" Menubar toggling
:let g:toggleMenu = 0
map <silent> <S-F1> :if g:toggleMenu == 1<CR>:set guioptions-=m<CR>:let g:toggleMenu = 0<CR>:else<CR>:set guioptions+=m<CR>:let g:toggleMenu = 1<CR>:endif<CR>

" Mouse/UI
set mouse=a                  " Enable mouse in all modes
if has("gui_running")
  set showtabline=1          " Show tabs only if > 1 open
  set guioptions-=T          " Hide toolbar
  set guioptions-=m          " Hide menu bar
  set lines=60 columns=120
endif
