" Check for all required executables, except for screen since neoterm
" handles terminal screens in neovim

"if !executable('screen')
"	call M2Warning("Please install 'screen' to run m2-plugin")
"	sleep 2
"	finish

if !executable('M2')
	call M2Warning("Please install 'M2' to run m2-plugin")
	sleep 2
	finish
endif

" Output a meaningful warning.
function! m2#M2Warning(msg)
	echohl WarningMsg
	echo a:msg
	echohl Normal
endfunction

" NOTE: The commented-out function below is no longer necessary, since neoterm
" handles starting M2

" Load M2 in a new terminal, named with b:screens
"function! m2#M2Start()
"	let cwd = getcwd() 
"	let cmd = printf("/usr/bin/osascript ~/.config/nvim/m2/VimM2.scpt %s %s" , cwd, b:screens)
"	let log = system(cmd)
"	if v:shell_error
"		call m2#M2Warning(log)
"		return
"	endif
"endfunction

" Load M2 in a neovim terminal window, or switch window to M2 if it already
" exists
function! m2#M2Start(toggle_off)
	let toggle_off = a:toggle_off
	let bnr = bufnr('neoterm-1')
	let bwinnr = bufwinnr('neoterm-1')
	if (bnr > 0 && toggle_off) || (bnr > 0 && bwinnr < 0)
		1Ttoggle
	elseif bwinnr > 0 && !toggle_off
	else
		Tnew
		TREPLSetTerm 1
		sleep 100m
		1T M2
	endif
endfunction

" Restart M2
function! m2#M2Restart()
	1T restart
endfunction

" Exit M2
function! m2#M2Exit()
	1Texec exit exit
endfunction

" NOTE: All functions below are no longer necessary, since the neoterm can
" handle M2 as a REPL

function! m2#M2SendString(str)

	" fix single quotes and then carets
	let sstr = substitute(a:str, "'", "'\\\\''", "g")
	let sstr = substitute(sstr, '\^', '\\\^', "g")
	let sstr = substitute(sstr, '\"', '\\\"', "g")
	" send the command: notice \015 is just newline
	let cmd = printf("screen -S %s -X eval 'stuff \"%s\n\"'", b:screens, sstr)
	let log = system(cmd)
	if v:shell_error
		call m2#M2Warning(log)
	endif
endfunction

" Send the current buffer to M2
function! m2#M2SendBuffer()
	call m2#M2Send("1", "$")
endfunction

" Fancy-schmancy general send
" Accepts inputs of either string, list<string>, or line1,line2
" Modified from screen.vim
function! m2#M2Send(...)
	" parse inputs
	if a:0 == 0
		let lines = [getline(".")]
	elseif a:0 == 1
		let ta1 = type(a:1)
		if ta1 == 1
			" strings: break up on newlines
			let lines = split(a:1, "\n")
		elseif ta1 == 3
			" lists: take-as-is
			let lines = a:1
		else
			call m2#M2Warning('m2-plugin: Argument must be a string or a list.')
			return
		endif
	elseif a:0 == 2
		if type(a:1) <= 1 && type(a:2) <= 1
			" integers/strings
			let lines = getline(a:1, a:2)
			let mode = visualmode(1)
			if mode != '' && line("'<") == a:1
				if mode == "v"
					let start = col("'<") - 1
					let end = col("'>") - 1
					" slice in end before start in case the selection is only one line
					let lines[-1] = lines[-1][: end]
					let lines[0] = lines[0][start :]
				elseif mode == "\<c-v>"
					let start = col("'<")
					if col("'>") < start
						let start = col("'>")
					endif
					let start = start - 1
					call map(lines, 'v:val[start :]')
				endif
			endif
		else
			call m2#M2Warning('m2-plugin: Arguments must be a pair of strings/integers.')
			return
		endif
	else
		call m2#M2Warning('m2-plugin: Invalid number of arguments.')
	endif
	" send them on!
	for lin in lines
		call m2#M2SendString(lin)
	endfor
endfunction
