set nocompatible
set encoding=utf-8

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'rhysd/vim-clang-format'
Plugin 'spacehi.vim'                " Highlight bad whitespace
Plugin 'vimwiki/vimwiki'

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

" Indentation/tabulation
set autoindent      " Copy indent from current line when starting a new line
set smartindent     " Attempt to autoindent when starting a new line
set smarttab        " Use shiftwidth rather than tabstop at start of line
set tabstop=2       " Number of spaces a tab counts for
set shiftwidth=2    " Number of spaces for each step of autoindent
set softtabstop=2   " Number of spaces a tab counts for when editing
set expandtab       " Insert spaces rather than tabs

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

" VimWiki
let wiki_1 = {}
let wiki_1.path = '~/Documents/wiki/'
let wiki_1.path_html = '~/Documents/wiki_html/'
let wiki_1.nested_syntaxes = {'c': 'c', 'c++': 'cpp'}
let wiki_2 = {}
let wiki_2.path = '~/Documents/gwiki/'
let wiki_2.path_html = '~/Documents/gwiki_html/'
let wiki_2.nested_syntaxes = {'c++': 'cpp', 'dart': 'dart'}
let g:vimwiki_list = [wiki_1, wiki_2]

" Personal wiki diary index, new entry, task list
nmap <leader>jw <Plug>VimwikiIndex
nmap <leader>jd <Plug>VimwikiDiaryIndex
nmap <leader>jn <Plug>VimwikiMakeDiaryNote
nmap <leader>jt :e ~/Documents/wiki/Tasks.wiki<CR>

" Work wiki diary index, new entry, task list
nmap <leader>kw 2<Plug>VimwikiIndex
nmap <leader>kd 2<Plug>VimwikiDiaryIndex
nmap <leader>kn 2<Plug>VimwikiMakeDiaryNote
nmap <leader>kt :e ~/Documents/gwiki/Tasks.wiki<CR>

" Wiki diary previous, next day
au FileType vimwiki nmap <leader>dp <Plug>VimwikiDiaryPrevDay
au FileType vimwiki nmap <leader>dn <Plug>VimwikiDiaryNextDay

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

  " Line numbers
  hi LineNr ctermfg=7

  " Highlight cursor line, max column
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
    au BufEnter,InsertLeave *.txt,*.md,*.wiki set colorcolumn=72
    au BufEnter,InsertLeave *.txt,*.md,*.wiki set textwidth=72
    au BufEnter,InsertLeave *.java,*.m,*.mm set colorcolumn=100
    au BufEnter,InsertLeave *.java,*.m,*.mm set textwidth=100

    " Highlight trailing space
    au BufEnter,InsertLeave *.bzl,*.c,*.cc,*.cs,*.dart,*.h,*.java,*.m,*.mm,*.py,*.s SpaceHi
  endif
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functions

" Insert the current date in '2020-04-22 (Thu)' format
nnoremap <Leader>cd i<C-R>=strftime('%Y-%M-%d (%a)')<CR><Esc>

" Apply clang-format to a range of lines (or all)
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
