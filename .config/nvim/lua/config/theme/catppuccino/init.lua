-- Theme
local variant = "dark_catppuccino"

local catppuccino = require("catppuccin")
local cp_api = require("catppuccin.api.colors")
local util = require("catppuccin.utils.util")
local _, colors = cp_api.get_colors(variant)

-- configure it
catppuccino.setup({
	-- colorscheme = variant,
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
		cmp = true,
		lsp_saga = false,
		gitgutter = false,
		gitsigns = true,
		telescope = true,
		nvimtree = {
			enabled = true,
			show_root = true,
		},
		which_key = true,
		indent_blankline = {
			enabled = false
		},
		dashboard = false,
		neogit = false,
		vim_sneak = false,
		hop = false,
		fern = false,
		barbar = false,
		bufferline = true,
		markdown = false,
	}
})

-- catppuccino.remap({}, {
-- 	HopNextKey = { bg = colors.bg, fg = colors.orange, style = "bold" },
-- 	HopNextKey1 = { bg = colors.bg, fg = colors.blue, style = "bold" },
-- 	HopNextKey2 = { bg = colors.bg, fg = util.darken(colors.blue, 0.80, colors.bg) },
-- 	HopUnmatched = { bg = colors.bg, fg = colors.comment },
-- })

catppuccino.load()
