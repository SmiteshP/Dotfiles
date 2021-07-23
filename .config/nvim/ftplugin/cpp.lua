function CompCoding_debug()
	vim.cmd("write")
	require("toggleterm").exec([[ g++ -std=c++17 -Wall -Wshadow -fsanitize=address -fsanitize=undefined -g -D_GLIBCXX_DEBUG -I ~/CompCoding/PCH_stdc++/debug/ ]] .. vim.fn.expand("%:t")
	.. [[; echo; if [ $? -eq 0 ]; then echo '\nOutput (debug)\t:' && /usr/bin/time -f '\nTime\t: %e seconds\nMemory\t: %M Kbytes' ./a.out < in; else echo 'Compilation error'; fi ]], 1)
	require("toggleterm").toggle(1)
end

function CompCoding_outfile()
	vim.cmd("write")
	require("toggleterm").exec([[ g++ -std=c++17 -O2 -I ~/CompCoding/PCH_stdc++/optimized/ ]] .. vim.fn.expand("%:t")
	.. [[; echo; if [ $? -eq 0 ]; then ./a.out < in > out; else echo 'Compilation error'; fi ]], 1)
	vim.cmd("echom 'Result written to outfile'")
end

function CompCoding_fast()
	vim.cmd("write")
	require("toggleterm").exec([[ g++ -std=c++17 -O2 -I ~/CompCoding/PCH_stdc++/optimized/ ]] .. vim.fn.expand("%:t")
	.. [[; echo; if [ $? -eq 0 ]; then echo '\nOutput (fast)\t:' && /usr/bin/time -f '\nTime\t: %e seconds\nMemory\t: %M Kbytes' ./a.out < in; else echo 'Compilation error'; fi ]], 1)
	require("toggleterm").toggle(1)
end

function CompCoding_interactive()
	vim.cmd("write")
	require("toggleterm").exec([[ g++ -std=c++17 -Wall -Wshadow -fsanitize=address -fsanitize=undefined -g -D_GLIBCXX_DEBUG -I ~/CompCoding/PCH_stdc++/debug/ ]] .. vim.fn.expand("%:t")
	.. [[; echo; if [ $? -eq 0 ]; then ./a.out; else echo 'Compilation error'; fi ]], 1)
	require("toggleterm").toggle(1)
end

local nmaps = {
	["<leader>r"] = {
		name = "CPP Run",
		["r"] = { "<cmd>lua CompCoding_debug()<CR>", "Debug" },
		["f"] = { "<cmd>lua CompCoding_outfile()<CR>", "Outfile" },
		["e"] = { "<cmd>lua CompCoding_fast()<CR>", "Fast" },
		["t"] = { "<cmd>lua CompCoding_interactive()<CR>", "Interactive" }
	}
}

local nopts = {
	mode = 'n',
	noremap = true,
	silent = true,
	buffer = vim.fn.bufnr()
}

require("which-key").register(nmaps, nopts)
