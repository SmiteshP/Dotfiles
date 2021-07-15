-- Set leader
vim.api.nvim_set_keymap('n', "<Space>", "<NOP>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', "<Space>", "<NOP>", {noremap = true, silent = true})
vim.g.mapleader = ' '

-- Global variables
Config = {
	theme = "material",
	lsp = {
		highlight = false
	},
	statusline = {
		minimal = false
	}
}

-- Source plugins
require("plugins")

-- Colorscheme
require("config.theme."..Config.theme)

-- Tab settings
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=0")

-- For LSP
vim.o.hidden = true
vim.o.updatetime = 300
vim.o.backup = false
vim.o.writebackup = false

-- Generic
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.cursorline = true
vim.wo.signcolumn = "yes"
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.scrolloff = 8
vim.o.showmode = false
vim.o.splitright = true
vim.o.termguicolors = true

vim.cmd("nnoremap <C-a> ggVG") -- Select All
vim.cmd('vnoremap <C-c> "+y')  -- Copy

vim.cmd[[
	augroup generic
	autocmd!
	autocmd BufEnter * silent! lcd %:p:h
	autocmd TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}
	augroup END
	]]

-- Disable some built-in plugins
local disabled_built_ins = {
	"netrwPlugin",
	"tohtml",
	"man",
	"tarPlugin",
	"zipPlugin",
	"gzip"
}

for i = 1, table.maxn(disabled_built_ins) do
	vim.g["loaded_" .. disabled_built_ins[i]] = 1
end
