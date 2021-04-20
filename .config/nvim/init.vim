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

	Plug 'neoclide/coc.nvim', {'branch': 'release'}

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
let g:material_terminal_italics = 1
let g:material_theme_style = 'ocean'
colorscheme material

" --- Plugin Settings ---

" * NerdTree *
let NERDTreeMinimalUI=1

" * airline theme *
let g:airline_theme = 'material'
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
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

"" } ------ Powerline symbols ------

"" ------ COC Settings ------ {

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
"set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
	" Recently vim can merge signcolumn and number column into one
	set signcolumn=number
else
	set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
	inoremap <silent><expr> <c-space> coc#refresh()
else
	inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
									\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	else
		execute '!' . &keywordprg . " " . expand('<cword>')
	endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
	autocmd!
	" Setup formatexpr specified filetype(s).
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	" Update signature help on jump placeholder.
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
	nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
	nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
	inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
	inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
	vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
	vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"" } ------ COC Settings ------
