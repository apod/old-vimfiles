" -------
" General
" -------

" Forget being compatible with good ol' vi
set nocompatible

" Pathogen initialization
call pathogen#infect()

" Syntax highlight and file type detection
syntax enable
filetype plugin indent on

" Allow unsaved background buffers
set hidden

" Bigger command history
set history=1000

set hlsearch                      " Highlight searches
set incsearch                     " ... incrementally as they are typed
set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set wrap                          " Turn on line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.

" Invisible character symbols
set listchars=tab:▶\ ,eol:¬

" Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Vim's encoding
set encoding=utf-8

" Intuitive backspacing
set backspace=indent,eol,start

" Default whitespace for all files
set ts=2 sts=2 sw=2 expandtab

colorscheme monokai_customized

" Always show status line
set laststatus=2

" Sync with system clipboard, requires +clipboard feature
if has('clipboard')
  set clipboard=unnamed
end

" --------
" Autocmds
" --------

" Disable autocommenting on o O
autocmd FileType * setlocal formatoptions-=o

" -------
" Keymaps
" -------

" Move around windows with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Move line down/up with <leader>jk
nmap <leader>j :m+<CR>
vmap <leader>j :m'>+<CR>gv
nmap <leader>k :m-2<CR>
vmap <leader>k :m-2<CR>gv

" Toggle highlight search
nmap <leader>l :set hls!<CR>

" Toggle invisible character symbols
nmap <leader>h :set list!<CR>

" ---
" GUI
" ---
if has("gui_macvim")
  set guifont=Menlo:h11 " Change font

  " Default dimensions for a new window
  set lines=80 columns=120

  " GUI customization
  set go-=T " Remove toolbar
  " Remove vertical scrolling from both sides
  set guioptions-=r
  set guioptions-=L
endif
