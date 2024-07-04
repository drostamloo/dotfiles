" Install vim-plug if not found
let plug_install = 0
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
    silent exe '!curl -fL --create-dirs -o ' . autoload_plug_path . 
        \ ' https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    execute 'source ' . fnameescape(autoload_plug_path)
    let plug_install = 1
endif
unlet autoload_plug_path

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

Plug 'lervag/vimtex'
    let g:tex_flavor='latex'
    let g:vimtex_view_method='zathura'
    let g:vimtex_quickfix_mode=2

	" Conceal settings
	
 	set conceallevel=2
    let g:vimtex_syntax_conceal = {
          \ 'accents': 1,
          \ 'ligatures': 1,
          \ 'cites': 1,
          \ 'fancy': 1,
          \ 'spacing': 1,
          \ 'greek': 1,
          \ 'math_bounds': 1,
          \ 'math_delimiters': 1,
          \ 'math_fracs': 1,
          \ 'math_super_sub': 1,
          \ 'math_symbols': 1,
          \ 'sections': 0,
          \ 'styles': 1,
          \}

    let g:vimtex_syntax_conceal_cites = {
          \ 'type': 'brackets',
          \ 'icon': '📖',
          \ 'verbose': v:true,
          \}

	let g:tex_conceal = 'abdmgs'
	let g:tex_superscripts= "[0-9a-zA-Z.,:;+-<>/()=]"
	let g:tex_subscripts= "[0-9a-zA-Z.,:;+-<>/()=]"

Plug 'SirVer/ultisnips'
    let g:UltiSnipsExpandTrigger = '<tab>'
    let g:UltiSnipsJumpForwardTrigger = '<tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" The following plugin no longer works with vimtex, since the latter has its
" own conceal feature since the release of v2
" Plug 'KeitaNakamura/tex-conceal.vim'
"     set conceallevel=2
"     let g:tex_conceal='abdmg'
"     hi Conceal ctermbg=none
" 	let g:tex_superscripts= \"[0-9a-zA-W.,:;+-<>/()=]"
" 	let g:tex_subscripts= \"[0-9aehijklmnoprstuvx,+-/().]"

Plug 'easymotion/vim-easymotion'

Plug 'arcticicestudio/nord-vim'

Plug '~/.config/nvim/m2'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting

" Install plugins if not yet installed
if plug_install
    PlugInstall --sync
endif
unlet plug_install

" UltiSnips Settings
let g:UltiSnipsExpandTrigger       = '<Tab>'    " use Tab to expand snippets
let g:UltiSnipsJumpForwardTrigger  = '<Tab>'    " use Tab to move forward through tabstops
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'  " use Shift-Tab to move backward through tabstops

" Other Settings
set tabstop=4 " Set tabstop to be length 4
set shiftwidth=4 " Set paragraph indent length 4
set number relativenumber " Set relative line numbering in the left margin
set so=999 " Set working line always in the center of screen whenever possible

" Line-wrap settings
set wrap linebreak
set breakindent
noremap j gj
noremap k gk

" Automatically change working directory to that of the current buffer's file
set autochdir

" Stop automatically continuing comments to newline by removing the letters
" 'cro' from the option 'formatoptions'
set formatoptions=jql

" Fix paste so that it respects indentation of previous line and jumps to end
" of pasted material
noremap p p`[v`]=`]
noremap P P`[v\]=`]

" Set vim colorscheme to Nord
function! MyHighlights() abort
	highlight Conceal guifg=#D8DEE9 guibg=none

	if $TERM_PROGRAM == 'Apple_Terminal'
		highlight Visual term=reverse ctermfg=none ctermbg=60 cterm=none guibg=#434C5E guifg=#D8DEE9 gui=none
	endif
endfunction

augroup MyColors
	autocmd!
	autocmd ColorScheme * call MyHighlights()
augroup END

colorscheme nord


" Set shortcut for switching buffers
nnoremap <Leader>b :buffers<CR>:buffer<Space>

" Source m2.vimrc init file from ~/.config/nvim/ directory
au BufRead,BufNewFile *.m2 so ~/.config/nvim/m2.vimrc
