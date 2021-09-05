-- Source
vim.cmd("packadd material.nvim")

-- Theme
vim.g.material_style = "deep ocean"

require("material").setup({
	contrast = true,
	borders = false,
	italics = {
		comments = true,
		strings = false,
		keywords = false,
		functions = false,
		variables = false
	},
	contrast_windows = {
		"terminal",
		"packer"
	},
	text_contrast = {
		lighter = false,
		darker = false
	},
	disable = {
		background = false,
		term_colors = false,
		eob_lines = false
	},
	custom_highlights = {}
})

vim.cmd[[colorscheme material]]
