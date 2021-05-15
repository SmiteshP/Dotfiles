nnoremap <Leader>r :call CompCoding_noOutfile()<CR>
nnoremap <Leader>rt :call CompCoding_terminal()<CR>
nnoremap <Leader>rf :call CompCoding_outfile()<CR>
nnoremap <Leader>re :call CompCoding_optim_noOutfile()<CR>
command -nargs=? Load call LoadFromLibrary(<q-args>)

function! CompCoding_outfile()
	:w
	! g++ -std=c++17 -O2 -I ~/CompCoding/PCH_stdc++/optimized/ %:t
	if v:shell_error == 1
		echom "Compilation error"
	else
		! ./a.out < in > out
	endif
endfunction

function! CompCoding_noOutfile()
	:w
	! g++ -std=c++17 -Wall -Wshadow -fsanitize=address -fsanitize=undefined -g -D_GLIBCXX_DEBUG -I ~/CompCoding/PCH_stdc++/debug/ %:t
	if v:shell_error == 1
		echom "Compilation error"
	else
		! echo "\nOutput (debug)\t:" && /usr/bin/time -f"\nTime\t: \%e seconds\nMemory\t: \%M Kbytes" ./a.out < in
	endif
endfunction

function! CompCoding_optim_noOutfile()
	:w
	! g++ -std=c++17 -O2 -I ~/CompCoding/PCH_stdc++/optimized/ %:t
	if v:shell_error == 1
		echom "Compilation error"
	else
		! echo "\nOutput (fast)\t:" && /usr/bin/time -f"\nTime\t: \%e seconds\nMemory\t: \%M Kbytes" ./a.out < in
	endif
endfunction

function! CompCoding_terminal()
	:w
	! g++ -std=c++17 -Wall -Wshadow -fsanitize=address -fsanitize=undefined -g -D_GLIBCXX_DEBUG -I ~/CompCoding/PCH_stdc++/debug/ %:t
	if v:shell_error == 1
		echom "Compilation error"
	else
		! gnome-terminal -- zsh -c "./a.out; echo; echo; echo Press Enter to exit; read line"
	endif
endfunction

function! LoadFromLibrary(fname)
	if strlen(a:fname) == 0
		:execute "0r ~/CompCoding/Library/template.cpp"
		:execute "normal Gddgg"
	else
		:execute join(["r ~/CompCoding/Library", join([a:fname, "cpp"], '.')], '/')
	endif
endfunction
