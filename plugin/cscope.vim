""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CSCOPE settings for vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" USAGE:
" Stick this file in your ~/.vim/plugin directory (or in a
" 'plugin' directory in some other directory that is in your
" 'runtimepath'.
"
" Based off cscope_maps.vim by Jason Duell <jduell@alumni.princeton.edu>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim...
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add the database pointed to by environment variable
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    " show msg when any other cscope db added
    set cscopeverbose


    """"""""""""" My cscope/vim key mappings
    "
    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    "
    " All of the maps involving the <cfile> macro use '^<cfile>$': this is so
    " that searches over '#include <time.h>" return only references to
    " 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
    " files that contain 'time.h' as part of their name).

    " To do the first type of search, hit the leader key, followed by one of
    " the cscope search types above (s,g,c,t,e,f,i,d).  The result of your
    " cscope search will be displayed in the current window.  You can use
    " CTRL-T to go back to where you were before the search.

    nmap <leader>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <leader>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <leader>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif
