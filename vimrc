"-----------------------------------------------------------------------
" Basic configuration.

set nomodeline " for security reasons
set nocompatible

filetype off " temporarily
silent! call pathogen#helptags() " Load bundles help
call pathogen#runtime_append_all_bundles() " Load bundles code

" Set leader to comma.
let mapleader = ","
let maplocalleader = ","

" Don't redraw screen while executing macros.
set nolazyredraw

" Behave intelligently for type of file.
filetype plugin indent on

" Syntax highlighting.
function! SyntaxToggle()
  execute "syntax" exists("g:syntax_on") ? "off" : "on"
endfunction
nmap <leader>s :call SyntaxToggle()<cr><C-l><cr>
syntax on

set ruler                         " Show cursor position.

" Give more context in viewport.
set scrolloff=3

" Scroll viewport faster.
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Encoding and line breaks.
set encoding=utf-8
set ffs=unix,dos

" Completion for file open etc.
set wildmenu
set wildmode=list:longest
set wildignore+=*.log,*.pdf,*.swp,*.o,*.hi,*.py[co],*~

" Ignore these when using TAB key with :e
set suffixes=~,.aux,.bak,.bkp,.dvi,.hi,.o,.pdf,.gz,.idx,.log,.ps,.swp,.tar,.ilg,.bbl,.toc,.ind

" Create backup files ending in ~, in ~/tmp or, if
" that is not possible, in the working directory.
set backup
set bex=.bak
" directories for backups
set backupdir=$HOME/.backup
set directory=$HOME/.backup

" Flexible backspace: allow backspacing over autoindent, line breaks, start of
" insert.
set backspace=indent,eol,start

" No audible bell.
set visualbell

" Show line and column position of cursor, with percentage.
set ruler

" Make tabs and trailing space visible on ,l
set listchars=tab:>-,trail:.
set list
nmap <silent> <leader>l :set invlist list?<cr>

" Show matching brackets.
set showmatch
set mat=5  " for half a sec

" Tabs:  default is four spaces.
set expandtab
set tabstop=4
set softtabstop=0
set shiftwidth=4  " for autoindent
set shiftround     " indent to a multiple of shiftwidth
set autoindent

nmap <leader>2 :set tabstop=2<cr>:set shiftwidth=2<cr>
nmap <leader>4 :set tabstop=4<cr>:set shiftwidth=4<cr>

" Reflow paragraphs intelligently. using 'par'.
set formatprg="par -h -w78 -B=.,\?_A_a "
map <C-\> !}par -h -w78 -B=.,\?_A_a <cr>

" Go to nearest match as you type.
set incsearch
set ignorecase  " ignore case in search and tags
set smartcase   " unless the pattern contains uppercase

" Set title of window according to filename.
set title

" Show command on last line.
set showcmd

" This sets soft wrapping:
" set wrap linebreak textwidth=0

:nmap ,w :w<cr>

" Don't force save when changing buffers
set hidden

" NOTE: Snipmate won't work in paste mode!
set pastetoggle=<F2>

" Remember more commands.
set history=2000

set undolevels=1000             " use many levels of undo

" Buffer movement (C-n - next, C-p - previous).
map <C-n> :bn<cr>
map <C-p> :bp<cr>

" Tab movement
" gt next tab
" gT prev tab
" 3gt tab 3

" Split window movement
map <F4> <C-W><C-W>
map <C-Up> <C-W><Up>
map <C-Down> <C-W><Down>
map <C-Right> <C-W><Right>
map <C-Left> <C-W><Left>

" Use <Leader>g to go to a url under cursor in UTL format <url:blah>
:map <Leader>g :Utl<cr>
:let g:utl_opt_highlight_urls='yes'
:let g:utl_cfg_hdl_mt_generic = 'silent !open "%p"&'

" s skips whitespace and puts cursor on next non-whitespace char
:map s :call search('\S','ceW')<cr>
" S skips preceding whitespace and puts cursor on last non-whitespace char
:map S :call search('\S','bceW')<cr>

" If for aesthetic reasons you want a left margin in writing text...
function! GutterLeft()
  set number
  highlight LineNr ctermfg=Black
endfunction

" Use space and backspace for quick navigation forward/back.
noremap <Space> <PageDown>
noremap <BS> <PageUp>

" for text files set width = 78 chars
autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position. Don't
" do it when the position is invalid or when inside an event handler (happens
" when dropping a file on gvim).
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal g`\"" |
\ endif

" Highlight according to markdown conventions in text files.
augroup text
  autocmd BufRead *.txt set ai formatoptions=tcroqn2 comments=n:>
augroup END

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
" thanks Douglas Potts).
map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Use zl to list buffers, and go to matching buffer
" Type part of bufname after prompt.
nmap zl :ls!<CR>:buf 

" Visit todo list
nmap <Leader>td :e ~/Wiki/TodoList<CR>
nmap <Leader>tr :e ~/Wiki/FuentesTrecetas<CR>

function! SearchWiki(searchTerm)
  exec ":vimgrep " . a:searchTerm . " ~/Wiki/*"
  exec ":copen"
endfunction

command -nargs=1 Find call SearchWiki(<f-args>)

" Read abbreviations file if present.
if filereadable(expand("~/.vim/abbrevs.vim"))
    source ~/.vim/abbrevs.vim
endif

" Colorscheme
let g:solarized_termcolors=16
let g:solarized_termtrans=0
let g:solarized_menu=0
let g:solarized_italic=0
set t_Co=16
syntax enable
set background=dark
colorscheme solarized

" cambiamos el color de fondo y frente del editor
hi Normal guibg=black guifg=white

function! TogBG()
    let &background = ( &background == "dark"? "light" : "dark" )
    exe "colorscheme " . g:colors_name
endfunction
map <leader>b :call TogBG()<cr>


"-----------------------------------------------------------------------
" GUI Settings {
if has("gui_running")
  exe "colorscheme " . g:colors_name
  set columns=80
  " set guifont=DejaVu\ Sans\ Mono\ 8  " set in ~/.vimrc
"  set guioptions=ce 
  "              ||
  "              |+-- use simple dialogs rather than pop-ups
  "              +  use GUI tabs, not console style tabs
  set lines=40
  set mousehide " hide the mouse cursor when typing
endif

"-----------------------------------------------------------------------
" Scripts and addons. These are managed by pathogen and live in bundle/.
" Most of them are git submodules, so I can keep up to date
"

" potwiki (personal wiki)
let potwiki_home = "$HOME/Wiki/WelcomePage"


" Detect twig filetype
au BufNewFile,BufRead *.twig set filetype=jinja.javascript

"Ranger
fun Ranger()
  silent !ranger --choosefile=/tmp/chosen
  if filereadable('/tmp/chosen')
    exec 'edit ' . system('cat /tmp/chosen')
    call system('rm /tmp/chosen')
  endif
  redraw!
endfun
map <leader>r :call Ranger()

set guifont=Menlo\ Regular:h14
