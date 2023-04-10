-- Theme
vim.g.material_style = "deep ocean"

require("material").setup({
	contrast = {
		terminal = false,
		sidebars = true,
		floating_windows = true,
		cursor_line = true,
		non_current_windows = true,
		filetypes = {
			"terminal",
			"packer"
		}
	},
	style = {
		comments = { italics = true },
		strings = {},
		keywords = {},
		functions = {},
		variables = {},
		operators = {},
		types = {},
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
	custom_highlights = {},
	plugins = {
		"dap",
		"dashboard",
		"gitsigns",
		"hop",
		"indent-blankline",
		"lspsaga",
		"mini",
		"neogit",
		"nvim-cmp",
		"nvim-navic",
		"nvim-tree",
		"nvim-web-devicons",
		"sneak",
		"telescope",
		"trouble",
		"which-key",
	},
})

vim.cmd[[colorscheme material]]
