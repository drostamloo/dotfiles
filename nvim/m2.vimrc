setfiletype m2
runtime! $VIMRUNTIME/syntax/m2.vim
set cpt+=k
set dict+=~/.config/nvim/dict/m2.vim.dict

" For David Cook's macros.
noremap <F12> :call m2#M2Start(1)<CR>
inoremap <F12> <ESC>:call m2#M2Start(1)<CR>i
noremap <F10> :call m2#M2Start(0)<CR>:TREPLSendLine<CR>j0
inoremap <F10> <ESC>:call m2#M2Start(0)<CR>:TREPLSendLine<CR>j0i
vnoremap <F10> :call m2#M2Start(0)<CR>:TREPLSendSelection<CR>
noremap <F9> :call m2#M2Exit()<CR>
inoremap <F9> <ESC>:call m2#M2Exit()<CR>i
noremap <F8> :call m2#M2Restart()<CR>
inoremap <F8> <ESC>:call m2#M2Restart()<CR>i

" From Tip 566 Vim Wikia
"Use TAB to complete when typing words, else inserts TABs as usual.
"Uses dictionary and source files to find matching words to complete.
"See help completion for source,
"Note: usual completion is on <C-n> but more trouble to press all the time.
"Never type the same word twice and maybe learn a new spellings!
"Use the Linux dictionary when spelling is in doubt.
"Window users can copy the file to their machine.
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
