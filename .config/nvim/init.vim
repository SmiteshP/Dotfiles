"" Pulgin manager Vim-Plug
call plug#begin('~/.config/nvim/plugged')

"	-- Colorschemes --
	Plug 'kaicataldo/material.vim'
	Plug 'bluz71/vim-nightfly-guicolors'
	"Plug 'joshdick/onedark.vim'
	"Plug 'juanedi/predawn.vim'

"	-- Syntax --
	"Plug 'sheerun/vim-polyglot'
	Plug 'octol/vim-cpp-enhanced-highlight', { 'for' : ['cpp', 'c'] }
	Plug 'vhda/verilog_systemverilog.vim', { 'for' : 'verilog_systemverilog' }

"	-- Decoration --
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

"	-- Productivity --
	Plug 'preservim/nerdtree'
	Plug 'Xuyuanp/nerdtree-git-plugin'
	Plug 'preservim/nerdcommenter'
	Plug 'jiangmiao/auto-pairs'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-repeat'
	Plug 'junegunn/fzf.vim'
	Plug 'airblade/vim-gitgutter'
	"Plug 'easymotion/vim-easymotion'

call plug#end()

" --- General Settings ---
set nu rnu
"syntax enable
set smartindent
set showcmd
set termguicolors
autocmd BufEnter * silent! lcd %:p:h
set noshowmode
set cursorline
set tabstop=4
set shiftwidth=0
set splitright

" --- Git Check ---
silent! !git rev-parse --is-inside-work-tree
if v:shell_error == 0
	let g:inside_git_repo = 1
else
	let g:inside_git_repo = 0
endif

" --- Key Bindings ---
let mapleader = ';'
vnoremap <C-c> "+y
nnoremap <C-a> ggVG
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <silent> <TAB> :bnext<CR>
nnoremap <silent> <S-TAB> :bprevious<CR>
nnoremap <silent> <Leader><TAB> :Buffers<CR>

autocmd BufEnter * call SetCtrlP()
function SetCtrlP()
	if g:inside_git_repo == 1
		noremap <C-p> :GFiles --cached --others --exclude-standard<CR>
	else
		noremap <C-p> :Files<CR>
	endif
endfunction

" --- Theme ---
set background=dark
let g:material_theme_style = 'ocean'
colorscheme material

" --- Plugin Settings ---

" * NerdTree *
let NERDTreeMinimalUI=1

" * FZF *
if has('nvim') && !exists('g:fzf_layout')
	autocmd! FileType fzf
	autocmd  FileType fzf set laststatus=0 noruler
		\| autocmd BufLeave <buffer> set laststatus=2 ruler
endif

" * airline theme *
let g:airline_theme = 'monochrome'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_min_count = 2
"autocmd BufDelete * call airline#extensions#tabline#buflist#invalidate()

" * vim easy-motion *
"map <Leader> <Plug>(easymotion-prefix)

" * git-gutter *
autocmd BufEnter * call SetGitGutter()
function SetGitGutter()
	if g:inside_git_repo == 1
		set updatetime=100
	else
		:GitGutterDisable
	endif
endfunction

" * YCM settings *
"let g:ycm_add_preview_to_completeopt = 1
"let g:ycm_autoclose_preview_window_after_completion = 1

" remove trailing whitespaces on write
command RemoveTrail call RemoveTrailingWhiteSpaces()
function RemoveTrailingWhiteSpaces()
	:%s/\s\+$//e
endfunction

"" ------ Competitive coding ------ {

autocmd FileType cpp call SetCompCodingKeys()
function SetCompCodingKeys()
	nnoremap <Leader>r :call CompCoding_noOutfile()<CR>
	nnoremap <Leader>rt :call CompCoding_terminal()<CR>
	nnoremap <Leader>rf :call CompCoding_outfile()<CR>
	nnoremap <Leader>re :call CompCoding_optim_noOutfile()<CR>
	command -nargs=? Load call LoadFromLibrary(<q-args>)
endfunction

function CompCoding_outfile()
	:w
	! g++ -std=c++17 -O2 -I ~/CompCoding/PCH_stdc++/optimized/ %:t
	if v:shell_error == 1
		echom "Compilation error"
	else
		! ./a.out < in > out
	endif
endfunction

function CompCoding_noOutfile()
	:w
	! g++ -std=c++17 -Wall -Wshadow -fsanitize=address -fsanitize=undefined -g -D_GLIBCXX_DEBUG -I ~/CompCoding/PCH_stdc++/debug/ %:t
	if v:shell_error == 1
		echom "Compilation error"
	else
		! echo "\nOutput (debug)\t:" && /usr/bin/time -f"\nTime\t: \%e seconds\nMemory\t: \%M Kbytes" ./a.out < in
	endif
endfunction

function CompCoding_optim_noOutfile()
	:w
	! g++ -std=c++17 -O2 -I ~/CompCoding/PCH_stdc++/optimized/ %:t
	if v:shell_error == 1
		echom "Compilation error"
	else
		! echo "\nOutput (fast)\t:" && /usr/bin/time -f"\nTime\t: \%e seconds\nMemory\t: \%M Kbytes" ./a.out < in
	endif
endfunction

function CompCoding_terminal()
	:w
	! g++ -std=c++17 -Wall -Wshadow -fsanitize=address -fsanitize=undefined -g -D_GLIBCXX_DEBUG -I ~/CompCoding/PCH_stdc++/debug/ %:t
	if v:shell_error == 1
		echom "Compilation error"
	else
		! gnome-terminal -- zsh -c "./a.out; echo; echo; echo Press Enter to exit; read line"
	endif
endfunction

function LoadFromLibrary(fname)
	if strlen(a:fname) == 0
		:execute "0r ~/CompCoding/Library/template.cpp"
		:execute "normal Gddgg"
	else
		:execute join(["r ~/CompCoding/Library", join([a:fname, "cpp"], '.')], '/')
	endif
endfunction

"" } ------ Competitive coding ------

"" ------ Powerline symbols ------ {
" airline
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

"" } ------ Powerline symbols ------
