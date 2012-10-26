" -------------------------
" unimpaired Customizations
" -------------------------

" Change the [e ]e mapping
nmap [e :m-2<CR>
xmap [e :m-2<CR>gv
nmap ]e :m+<CR>
xmap ]e :m'>+<CR>gv


" Disable [o ]o mappings 
nmap <Plug>unimpairedOPrevious <Nop>
nmap <Plug>unimpairedONext <Nop>
