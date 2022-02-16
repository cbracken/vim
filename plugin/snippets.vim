" Code snippets

" Insert the current date in '2020-04-22 (Thu)' format.
nnoremap <Leader>cd i<C-R>=CurrentDate()<CR><Esc>

" Returns the current date in YYYY-mm-dd form.
" When in a file whose name is of the form YYYY-mm-dd, use that date instead.
" This is useful for headings in VimWiki entries.
function! CurrentDate()
  " Get the filename without path or extension.
  let fname = expand('%:t:r')
  if fname =~ '\d\d\d\d-\d\d-\d\d'
    let fdate = strptime('%Y-%m-%d', fname)
    return strftime('%Y-%m-%d (%a)', fdate)
  else
    return strftime('%Y-%m-%d (%a)')
  endif
endfunc


" Inject a boilerplate C/C++/Obj-C main() function.
au FileType c,cpp,objc nmap <leader>cm iint main(int argc, char** argv) {<CR>return 0;<CR>}<ESC>%0
