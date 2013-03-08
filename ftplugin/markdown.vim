command! -buffer Preview :
      \ silent exe "!open -a 'Marked.app' '%:p'" | redraw!

