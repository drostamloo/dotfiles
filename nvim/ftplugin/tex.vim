" Use `dsm` to delete surrounding math (replacing the default shorcut `ds$`)
" and similarly for `csm` and `tsm`
nmap dsm <Plug>(vimtex-env-delete-math)
nmap csm <Plug>(vimtex-env-change-math)
nmap tsm <Plug>(vimtex-env-toggle-math)

" Use `ai` and `ii` for the item text object
omap ai <Plug>(vimtex-am)
xmap ai <Plug>(vimtex-am)
omap ii <Plug>(vimtex-im)
xmap ii <Plug>(vimtex-im)

" Use `am` and `im` for the inline math text object
omap am <Plug>(vimtex-a$)
xmap am <Plug>(vimtex-a$)
omap im <Plug>(vimtex-i$)
xmap im <Plug>(vimtex-i$)

" Disable vimtex insert mode mappings
let g:vimtex_imaps_enabled = 0

" Example: make `<leader>wc` call the command `VimtexCountWords`;
" you might place this code in ftplugin/tex.vim.
noremap <leader>wc <Cmd>VimtexCountWords<CR>

" Use `<localleader>c` to trigger continuous compilation...
nmap <localleader>c <Plug>(vimtex-compile)

" Don't open QuickFix for warning messages if no errors are present
let g:vimtex_quickfix_open_on_warning = 0

" Specify PDF viewer
let g:vimtex_view_method = 'zathura'

" Define a custom shortcut to trigger VimtexView
nmap <localleader>v <plug>(vimtex-view)

" Change build directory

let g:vimtex_compiler_latexmk = {
			\ 'aux_dir': "Auxiliary"
			\ }

"let g:vimtex_compiler_latexmk = {
"			\ 'aux_dir': {-> expand("%:t:r") . \" Auxiliary"},
"			\ 'out_dir': {-> expand("%:t:r") . \" Output"}
"			\ }

function! s:TexFocusVim() abort
  " Replace `TERMINAL` with the name of your terminal application
  " Example: execute "!open -a iTerm"  
  " Example: execute "!open -a Alacritty"
  silent execute "!open -a Alacritty"
  redraw!
endfunction

augroup vimtex_event_focus
  au!
  au User VimtexEventViewReverse call s:TexFocusVim()
augroup END
