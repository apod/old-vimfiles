" -------------------------
" unimpaired Customizations
" -------------------------

" Change the [e ]e mapping
xnoremap <silent> <Plug>unimpairedMoveUp   :<C-U>exe "'<,'>move--".v:count1<CR>gv
xnoremap <silent> <Plug>unimpairedMoveDown :<C-U>exe "'<,'>move'>+".v:count1<CR>gv

" Disable [o ]o mappings 
nmap [o <Nop>
nmap ]o <Nop>
