" Only do this when not done yet for this buffer
if exists("b:php_ftplugin_loaded")
    finish
endif
let b:php_ftplugin_loaded = 1

" PHP syntax options
let php_sql_query = 0 "Coloration des requetes SQL
let php_htmlInStrings = 0 "Coloration des balises HTML
let php_no_shorttags = 1
let php_folding = 0

" Use errorformat for parsing PHP error output
setlocal errorformat=%m\ in\ %f\ on\ line\ %l

" Because I write this shit so often
imap <buffer> ` ->
imap <C-j> $this->

" Insert current class name in lowercase
nmap <buffer> <leader>lcn "=tolower(expand("%:t:r"))<CR>P

map <buffer> <leader>e :s/^\(.*\)$/    protected $\1;/<CR>

" Insert full

" Insert current namespace and opens php and create empty class
map <F9> ggO<?php<CR><CR><ESC>"%PdF/r;:s#/#\\#g<CR>Inamespace <ESC>Goclass <C-R>=expand("%:t:r")<CR><CR>{<CR>

map <buffer> <leader>ce gg/class <CR>O/**<CR><ESC>d0i <ESC>A @ORM\Entity<CR>@ORM\Table(name="<C-R>=tolower(expand("%:t:r"))<CR>")<CR>/

" Insert use statements based on ctags
map <buffer> <leader>pu :call PhpInsertUse()<CR>

" Single line mode documentation
nnoremap <buffer> <leader>pd :call PhpDocSingle()<CR>

" Multi line mode documentation (in visual mode)
vnoremap <buffer> <leader>pd :call PhpDocRange()<CR>

" Align selected code
vnoremap <buffer> <leader>pa :call PhpAlign()<CR>
noremap <buffer> <leader>p{ vi{:call PhpAlign()<CR>
noremap <buffer> <leader>p} vi}:call PhpAlign()<CR>
noremap <buffer> <leader>p( vi(:call PhpAlign()<CR>
noremap <buffer> <leader>p) vi):call PhpAlign()<CR>

let g:pdv_cfg_Author = "Nacho Martín <nitram.ohcan@gmail.com>"
let g:pdv_cfg_License = "MIT {@link http://opensource.org/licenses/mit-license.html}"
let g:pdv_cfg_Copyright = "2011"
let g:pdv_cfg_php4always = 0 " Ignore PHP4 tags
" Wether to create @uses tags for implementation of interfaces and inheritance
let g:pdv_cfg_Uses = 0
" Wether for PHP5 code PHP4 tags should be set, like @access,... (1|0)?
let g:pdv_cfg_php4always = 0
" Wether to guess scopes after PEAR coding standards:
" $_foo/_bar() == <private|protected> (1|0)?
let g:pdv_cfg_php4guess = 0

func! PhpAlign() range
    let l:paste = &g:paste
    let &g:paste = 0

    let l:line = a:firstline
    let l:endline = a:lastline
    let l:maxlength = 0
    while l:line <= l:endline
" Skip comment lines
if getline (l:line) =~ '^\s*\/\/.*$'
let l:line = l:line + 1
continue
endif
" \{-\} matches ungreed *
        let l:index = substitute (getline (l:line), '^\s*\(.\{-\}\)\s*\S\{0,1}=\S\{0,1\}\s.*$', '\1', "")
        let l:indexlength = strlen (l:index)
        let l:maxlength = l:indexlength > l:maxlength ? l:indexlength : l:maxlength
        let l:line = l:line + 1
    endwhile

let l:line = a:firstline
let l:format = "%s%-" . l:maxlength . "s %s %s"

while l:line <= l:endline
if getline (l:line) =~ '^\s*\/\/.*$'
let l:line = l:line + 1
continue
endif
        let l:linestart = substitute (getline (l:line), '^\(\s*\).*', '\1', "")
        let l:linekey = substitute (getline (l:line), '^\s*\(.\{-\}\)\s*\(\S\{0,1}=\S\{0,1\}\)\s\(.*\)$', '\1', "")
        let l:linesep = substitute (getline (l:line), '^\s*\(.\{-\}\)\s*\(\S\{0,1}=\S\{0,1\}\)\s\(.*\)$', '\2', "")
        let l:linevalue = substitute (getline (l:line), '^\s*\(.\{-\}\)\s*\(\S\{0,1}=\S\{0,1\}\)\s\(.*\)$', '\3', "")

        let l:newline = printf (l:format, l:linestart, l:linekey, l:linesep, l:linevalue)
        call setline (l:line, l:newline)
        let l:line = l:line + 1
    endwhile
    let &g:paste = l:paste
endfunc
