" Code snippets

" Insert the current date in '2020-04-22 (Thu)' format.
nnoremap <Leader>cd i<C-R>=strftime('%Y-%m-%d (%a)')<CR><Esc>

" Inject a boilerplate C/C++/Obj-C main() function.
au FileType c,cpp,objc nmap <leader>cm iint main(int argc, char** argv) {<CR>return 0;<CR>}<ESC>%0
