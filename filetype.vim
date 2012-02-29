if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  au! BufRead,BufNewFile *.leg setfiletype c
  au! BufRead,BufNewFile {TODO,todo,TodoList} setfiletype todo
  au! BufRead,BufNewFile *.txt setfiletype text 
  au! BufRead,BufNewFile *.st setfiletype stringtemplate
  au BufNewFile,BufRead *.xt  setf xt
augroup END
                                                           
runtime! ftdetect/*.vim
