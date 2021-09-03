-- Source
vim.cmd("packadd Catppuccino.nvim")

-- Theme
local catppuccino = require("catppuccino")

-- configure it
catppuccino.setup(
{
	colorscheme = "dark_catppuccino",
	transparency = false,
	term_colors = false,
	styles = {
		comments = "italic",
		functions = "NONE",
		keywords = "NONE",
		strings = "NONE",
		variables = "NONE",
	},
	integrations = {
		treesitter = true,
		native_lsp = {
			enabled = true,
			styles = {
				errors = "italic",
				hints = "italic",
				warnings = "italic",
				information = "italic"
			}
		},
		lsp_trouble = false,
		lsp_saga = false,
		gitgutter = false,
		gitsigns = true,
		telescope = true,
		nvimtree = {
			enabled = true,
			show_root = true,
		},
		which_key = true,
		indent_blankline = true,
		dashboard = false,
		neogit = false,
		vim_sneak = false,
		hop = true,
		fern = false,
		barbar = false,
		bufferline = true,
		markdown = false,
	}
}
)

catppuccino.load()
