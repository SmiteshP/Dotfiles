-- Source
vim.cmd("packadd material.nvim")

-- Theme
vim.g.material_style = "deep ocean"

require("material").setup({
	contrast = {
		sidebars = true,
		floating_windows = true,
		line_numbers = false,
		sign_column = false,
		cursor_line = true,
		popup_menu = true
	},
	italics = {
		comments = true,
		strings = false,
		keywords = false,
		functions = false,
		variables = false
	},
	contrast_filetypes = {
		"terminal",
		"packer"
	},
	high_visibility = {
		lighter = false,
		darker = false
	},
	disable = {
		colored_cursor = true,
		borders = false,
		background = false,
		term_colors = false,
		eob_lines = false
	},
	custom_highlights = {}
})

vim.cmd[[colorscheme material]]
