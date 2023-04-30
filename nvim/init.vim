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
    let g:vimtex_view_method='skim'
    let g:vimtex_quickfix_mode=2

Plug 'SirVer/ultisnips'
    let g:UltiSnipsExpandTrigger = '<tab>'
    let g:UltiSnipsJumpForwardTrigger = '<tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

Plug 'KeitaNakamura/tex-conceal.vim'
    set conceallevel=2
    let g:tex_conceal='abdmg'
    hi Conceal ctermbg=none
	let g:tex_superscripts= "[0-9a-zA-W.,:;+-<>/()=]"
	let g:tex_subscripts= "[0-9aehijklmnoprstuvx,+-/().]"

Plug 'easymotion/vim-easymotion'

Plug 'arcticicestudio/nord-vim'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting

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

" Stop automatically continuing comments to newline
set formatoptions=jql

" Automatically go to end of pasted material after pasting
noremap p gp
noremap P gP

" Set nvim colorscheme to Nord
colorscheme nord
