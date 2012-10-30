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

" --------
" Autocmds
" --------

" Disable autocommenting on o O
autocmd FileType * setlocal formatoptions-=o

" Enable spellchecking for text files
autocmd FileType text setlocal spell spelllang=en,el

" ... and commit logs
autocmd FileType *commit* setlocal spell

" -------
" Keymaps
" -------

" Move around windows with <C-hjkl>
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" <C-pn> should filter the command history like <Up>/<Down>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Mute highlight until next search
nmap <leader>l :nohlsearch<CR>

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
