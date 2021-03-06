" Basic configuration.
set nomodeline " for security reasons
set nocompatible

" Temporarly, while vundle loads bundles.
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'Solarized'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'bockel/potwiki.vim'
Plugin 'tpope/vim-surround'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'kien/ctrlp.vim'
Plugin 'Shougo/neocomplete.vim'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'spf13/PIV'
Plugin 'arnaud-lb/vim-php-namespace'
Plugin 'beyondwords/vim-twig'
Plugin 'joonty/vdebug'
Plugin 'stephpy/vim-php-cs-fixer'
Plugin 'wting/rust.vim'
Plugin 'zerowidth/vim-copy-as-rtf'
Plugin 'elixir-lang/vim-elixir'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'guns/vim-clojure-static'
Plugin 'tpope/vim-fireplace'
Plugin 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plugin 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
Plugin 'scrooloose/syntastic'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tobyS/vmustache'
Plugin 'tobyS/pdv'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'ervandew/supertab'
Plugin 'lambdatoast/elm.vim'


call vundle#end()

" Resume operations and behave intelligently for type of file.
filetype plugin indent on

" Set leader to comma.
let mapleader = ","
let maplocalleader = ","

" Don't redraw screen while executing macros.
set nolazyredraw

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
map <leader>i :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>o :w <C-R>=expand("%:p:h") . "/" <CR>

" Use zl to list buffers, and go to matching buffer
" Type part of bufname after prompt.
nmap zl :ls!<CR>:buf 

" Visit todo list
nmap <Leader>td :e ~/Wiki/TodoList<CR>

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

" Change background and foreground color
hi Normal guibg=black guifg=white


"-----------------------------------------------------------------------
" GUI Settings {
if has("gui_running")
  exe "colorscheme " . g:colors_name
  set columns=80
  " set guifont=DejaVu\ Sans\ Mono\ 8  " set in ~/.vimrc
  " set guioptions=ce
  "              ||
  "              |+-- use simple dialogs rather than pop-ups
  "              +  use GUI tabs, not console style tabs
  set lines=40
  set mousehide " hide the mouse cursor when typing
endif

"-----------------------------------------------------------------------
" Scripts and addons. These are managed by vundle and live in bundle/.
"

" potwiki (personal wiki)
let potwiki_home = "$HOME/Wiki/WelcomePage"

" Detecting Pollen filetype
au BufNewFile,BufRead *.pm set filetype=html.pollen

" first set path
set path+=**

" Machine specifics in case we need them
source ~/.vim/machine_specifics

" Racket
if has("autocmd")
    au BufReadPost *.rkt,*.rktl set filetype=scheme
endif

" funky
let g:ctrlp_extensions = ['funky']
nnoremap <Leader>fu :CtrlPFunky<Cr>

"neocomplete
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_auto_delimiter = 1
let g:neocomplete#max_list = 15
let g:neocomplete#force_overwrite_completefunc = 1


" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.vimshell_hist',
            \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'


" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

" CtrlPFunky Buffers
nmap <leader>z :CtrlPBuffer<cr>

" TagBar
nmap <leader>tb :TagbarToggle<cr>

" NerdTree
map <leader>n :NERDTreeToggle<CR>
map <C-e> <plug>NERDTreeTabsToggle<CR>
map <leader>nf :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeFind<CR>

let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0

" PIV
" except for php_folding, the rest of lines have no meaning at all, as they
" have to be changed directly in PIV, but at least I know what to change there
" by writting them here
let g:DisableAutoPHPFolding = 1
let php_folding = 0
let g:pdv_cfg_foldmarker = 0
let g:load_doxygen_syntax = 0

"php-namespace
inoremap <Leader>u <C-O>:call PhpInsertUse()<CR>
noremap <Leader>u :call PhpInsertUse()<CR>
inoremap <Leader>ec <C-O>:call PhpExpandClass()<CR>
noremap <Leader>ec :call PhpExpandClass()<CR>

"vdebug
let g:vdebug_options = {
\ 'server': '0.0.0.0'
\}

let g:vdebug_options["break_on_open"]=0

" phpcscodefixer
let g:php_cs_fixer_path = "/usr/local/bin/php-cs-fixer" " define the path to the php-cs-fixer.phar
nnoremap <silent><leader>pcd :call PhpCsFixerFixDirectory()<CR>
nnoremap <silent><leader>pcf :call PhpCsFixerFixFile()<CR>:o<CR>

" solarized toggle background
function! ToggleBackground()
    if (w:solarized_style=="dark")
    let w:solarized_style="light"
    colorscheme solarized
else
    let w:solarized_style="dark"
    colorscheme solarized
endif
endfunction
command! Togbg call ToggleBackground()
nnoremap <leader>b :call ToggleBackground()<CR>
inoremap <leader>b <ESC>:call ToggleBackground()<CR>
vnoremap <leader>b <ESC>:call ToggleBackground()<CR>

autocmd BufNewFile,BufRead *.json set ft=javascript

let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

" Rainbow Parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"" Vim Javascript
"set conceallevel=1
"set concealcursor=nvic
"let g:javascript_conceal_function   = "ƒ"

" JSX goodies
let g:jsx_ext_required = 0

" Syntastic
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_php_checkers = ['php', 'phpcs']
let g:syntastic_html_checkers = []
let g:syntastic_php_phpcs_args = "--report=csv --standard=WordPress"

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Mouse scroll in Iterm
set mouse=a
if has("mouse_sgr")
    set ttymouse=sgr
else
    set ttymouse=xterm2
end


" ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" pdv
let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
nnoremap <leader>pv :call pdv#DocumentWithSnip()<CR>
