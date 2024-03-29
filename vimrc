" -------
" General
" -------

" Forget being compatible with good ol' vi
set nocompatible

" Pathogen initialization
call pathogen#infect()
call pathogen#infect('~/Projects/Vim/bundle')

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

" Relative line numbers
set relativenumber

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

colorscheme jellybeans

" Always show status line
set laststatus=2

" Keycode sequence timeout (ms)
set ttimeoutlen=100

" --------
" Autocmds
" --------

augroup filetypes_general
  autocmd!

  " Disable autocommenting on o O
  autocmd FileType * setlocal formatoptions-=o

  " Enable spellchecking for text files
  autocmd FileType text setlocal spell spelllang=en,el

  " ... and commit logs
  autocmd FileType *commit* setlocal spell

  " Disable it for help files
  autocmd FileType help setlocal nospell

  " Some default whitespace settings
  autocmd FileType ruby,yaml      setlocal ts=2 sts=2 sw=2 et
  autocmd FileType eruby,html,css setlocal ts=4 sts=4 sw=4 et
  autocmd FileType python         setlocal ts=4 sts=4 sw=4 et
  autocmd FileType javascript     setlocal ts=2 sts=2 sw=2 et
  autocmd FileType coffee         setlocal ts=2 sts=2 sw=2 et
augroup END


function! NetrwMappings()
  nnoremap <buffer><silent> o :<C-u>execute "call feedkeys('\r')"<cr>
endfunction

augroup netrw_mappings
  autocmd!

  autocmd FileType netrw call NetrwMappings()
augroup END

function! CoffeScriptMappings()
  nnoremap <leader>cc :CoffeeCompile vert"<cr><C-w>h
  nnoremap <leader>cw :CoffeeCompile watch vert"<cr>
endfunction

augroup coffeescript_mappings
  autocmd!

  autocmd FileType coffee call CoffeScriptMappings()
augroup END

function! RubyMappings()
  nmap <leader>mm <Plug>(xmpfilter-mark)
  nmap <leader>mn <Plug>(xmpfilter-run)
  vmap <leader>mm <Plug>(xmpfilter-mark)
  vmap <leader>mn <Plug>(xmpfilter-run)
endfunction

augroup ruby_mappings
  autocmd!

  autocmd FileType ruby call RubyMappings()
augroup END

" --------
" Mappings
" --------

" Switch j/k with gj/gk to move on display lines
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" Remap manual page key K to nothing
nnoremap K <Nop>
vnoremap K <Nop>

" Remap H and L to move to the first/last character of the line
nnoremap H ^
nnoremap L $
xnoremap H ^
xnoremap L $

" Move around windows with <C-hjkl>
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" <C-pn> should filter the command history like <Up>/<Down>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" <C-a> should move the cursor position to the start of the command-line
cnoremap <C-a> <Home>

" Yank and put to/from the "* register
vnoremap <leader>y "*y
nnoremap <leader>p :put *<CR>
nnoremap <leader>P :put! *<CR>

" Mute highlight until next search
nmap <silent> <leader>l :nohlsearch<CR>

" Toggle invisible character symbols
nmap <silent> <leader>h :set list!<CR>

" Map <leader>e to pen files in the same directory as the current file
cnoremap %% <C-r>=expand('%:h') . '/'<CR>
nmap <leader>e :edit %%

" Map <leader><leader> to switch to alternate file <C-^>
nmap <leader><leader> <C-^>

" Fugitive
nmap <leader>gst :Gstatus<CR>

" CtrlP
nmap <leader>b  :CtrlPBuffer<CR>
nmap <leader>tb :CtrlPBufTag<CR>
nmap <leader>ta :CtrlPBufTagAll<CR>
nmap <leader>tt :CtrlPTag<CR>

" Tagbar
nmap <silent> <leader>] :TagbarToggle<CR>

" NERDTree
nmap <silent> <leader>[ :NERDTreeToggle<CR>

" --------
" Commands
" --------

" Extract visual selection
xnoremap <leader>r :ExtractVisualSelection <C-r>=expand('%:h') . '/'<CR>

command! -range -bar -nargs=1 -bang -complete=file ExtractVisualSelection :
      \ let s:starts_at = expand(<line1>) |
      \ let s:ends_at = expand(<line2>) |
      \ let s:dst = expand(<q-args>) |
      \ execute s:starts_at . ',' . s:ends_at . 'write<bang>' . s:dst |
      \ execute s:starts_at . ',' . s:ends_at . 'delete' |
      \ execute 'rightbelow vsplit' . s:dst |
      \ execute 'normal =G' |
      \ unlet s:starts_at |
      \ unlet s:ends_at |
      \ unlet s:dst


" :SudoWrite and :Rename borrowed from vim-eunuch
" https://github.com/tpope/vim-eunuch

" Use :SudoWrite to write a file using sudo
command! -bar SudoWrite :
      \ setlocal nomodified |
      \ silent exe 'write !sudo tee % >/dev/null' |
      \ let &modified = v:shell_error

" Use :Rename to rename a file
command! -bar -nargs=1 -bang -complete=file Rename :
      \ let s:src = expand('%:p') |
      \ let s:dst = expand(<q-args>) |
      \ if isdirectory(s:dst) |
      \   let s:dst .= '/' . fnamemodify(s:src, ':t') |
      \ endif |
      \ if <bang>1 && filereadable(s:dst) |
      \   exe 'keepalt saveas '.fnameescape(s:dst) |
      \ elseif rename(s:src, s:dst) |
      \   echoerr 'Failed to rename "'.s:src.'" to "'.s:dst.'"' |
      \ else |
      \   setlocal modified |
      \   exe 'keepalt saveas! '.fnameescape(s:dst) |
      \   if s:src !=# expand('%:p') |
      \     execute 'bwipe '.fnameescape(s:src) |
      \   endif |
      \ endif |
      \ unlet s:src |
      \ unlet s:dst

" ---------------------
" Plugin Customizations
" ---------------------

" CtrlP
let g:ctrlp_custom_ignore = { 
      \ 'dir': '\v[\/]\.(git|hg|svn|bundle|idea)|log|tmp|vendor|bin',
      \ 'file': '\v\.(exe|jpg|png|gif|swf)$',
      \ }

let g:ctrlp_cache_dir = $HOME.'/.vim-tmp/ctrlp'

" UltiSnips
let g:UltiSnipsSnippetsDir = $HOME.'/.vim/snippets'
let g:UltiSnipsSnippetDirectories = ['snippets']

" NERDTree
let g:NERDTreeShowHidden = 1   " Show hidden files by default
let g:NERDTreeHijackNetrw = 0  " Use netrw instead of NERDTree on :Explore
let g:NERDTreeIgnore = ['\~$', '\.git$']

" Gist
let g:gist_post_private = 1
let g:gist_show_privates = 1
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let g:gist_get_multiplefile = 1

" Switch
nnoremap - :Switch<cr>

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

" --------------------
" FoldModeToggle (WiP)
" --------------------

nnoremap <leader>f :call FoldModeToggle()<CR>

function! FoldModeToggle()
  if &foldcolumn
    setlocal foldcolumn=0
    setlocal foldmethod=manual
    normal! zE
  else
    setlocal foldcolumn=4
    setlocal foldmethod=syntax
    normal! zR
  endif
endfunction
