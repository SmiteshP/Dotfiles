-- Bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=main", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Set leader
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

-- Tab settings
vim.o.tabstop = 4
vim.o.shiftwidth = 0

-- For LSP
vim.o.hidden = true
vim.o.updatetime = 300
vim.o.backup = false
vim.o.writebackup = false

-- Which-key Delay
vim.o.timeoutlen = 400

-- Generic
vim.o.number = true
vim.o.cursorline = true
vim.o.signcolumn = "yes"
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.scrolloff = 8
vim.o.showmode = false
vim.o.splitright = true
vim.o.termguicolors = true
vim.o.winblend = 10
vim.o.pumblend = 10

-- Plugins
require("config.lazy")

-- Autocmds
local generic_augroup = vim.api.nvim_create_augroup("config_generic", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
	group = generic_augroup,
	callback = function()
		if vim.o.buftype ~= "terminal" then
			vim.cmd("lcd %:p:h")
		end
	end
})
vim.api.nvim_create_autocmd("TextYankPost", {
	group = generic_augroup,
	callback = function()
		vim.highlight.on_yank({higroup = "IncSearch",
							   timeout = 150,
							   on_visual = true})
	end
})
