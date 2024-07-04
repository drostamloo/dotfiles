" Author:       David Cook II <dcook@ms.uky.edu>
" Version:      0.1
" License:      Public Domain, 2010
" Description:  This plugin was developed to allow easier access to Macaulay 2 from within VIM.
" Caveat:       Many constants are hard-coded; to be fixed later.

" Author:       Manoj Kummini <mkummini@cmi.ac.in> 
" Description:  Modification to run on Apples, with Terminal.app
" Screen Session name
"let b:screens = printf("vim-M2-plugin-%s", localtime())
let b:screens ="m2-plugin"
" Terminal geometry (WxH+X+Y)
let b:termgeom="80x25+0-0"

" Add Commands
command! -nargs=1 M2Warning call m2#M2Warning(<args>)
command! -nargs=0 M2Start call m2#M2Start()
command! -nargs=0 M2Restart call m2#M2Restart()
command! -nargs=0 M2Exit call m2#M2Exit()
command! -nargs=1 M2SendString call m2#M2SendString(<args>)
command! -nargs=0 M2SendBuffer call m2#M2SendBuffer()
command! -nargs=0 -range M2Send call m2#M2Send(<line1>,<line2>)
