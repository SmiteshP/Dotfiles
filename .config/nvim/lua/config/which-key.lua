local wk = require("which-key")

wk.setup {
	plugins = {
		marks = true,
		registers = true,
		spelling = {
			enabled = true,
			suggestions = 36,
		},
		presets = {
			operators = false,
			motions = false,
			text_objects = false,
			windows = true,
			nav = true,
			z = true,
			g = true,
		},
	},
	key_labels = {
		["<space>"] = "SPC",
		["<cr>"] = "RET",
		["<Tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»",
		separator = "➜",
		group = "+",
	},
	window = {
		border = "single",
		position = "bottom",
		winblend = vim.o.winblend,
		margin = { 1, 0, 1, 0 },
		padding = { 0, 2, 0, 2 },
	},
	layout = {
		height = { min = 4, max = 25 },
		width = { min = 20, max = 50 },
		spacing = 3,
		align = "left",
	},
	ignore_missing = false,
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "},
	show_help = true,
	triggers = "auto",
	triggers_blacklist = {
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

local nmaps = {
	["<c-\\>"] = {
		name = "Terminal",
		["<c-\\>"] = "Toggle Terminal"
	},
	["<c-a>"] = { "ggVG", "Select All" },
	["<c-p>"] = { "<cmd>Telescope find_files<CR>", "Find files" },
	["<Tab>"] = { "<cmd>BufferLineCycleNext<CR>", "Next Buffer" },
	["<S-Tab>"] = { "<cmd>BufferLineCyclePrev<CR>", "Prev Buffer" },
	["<leader>"] = {
		t = { "<cmd>NvimTreeToggle<CR>", "File Tree" },
		c = {
			name = "Comment",
			c = { "Comment Line" },
			O = { "Comment Line Above "},
			o = { "Comment Line Below "},
			A = { "Comment at End of Line"}
		},
		b = {
			name = "Comment Block",
			c = "Comment Block"
		},
		f = {
			name = "Find",
			f = { "<cmd>Telescope find_files<CR>", "Files" },
			g = { "<cmd>Telescope live_grep<CR>", "Grep" },
			o = { "<cmd>Telescope oldfiles<CR>", "Old Files" }
		},
		x = { "<cmd>bdelete<CR>", "Close Buffer" },
		["<Tab>"] = { "<cmd>Telescope buffers<CR>", "Show Buffers" },
		['.'] = { "<cmd>BufferLineMoveNext<CR>", "Buf Move Right" },
		[','] = { "<cmd>BufferLineMovePrev<CR>", "Buf Move Left" },
		["s"] = { "<cmd>Navbuddy<CR>", "Navbuddy" }
	},
}

local vmaps = {
	["<c-c>"] = { "\"+y", "Copy to Clipboard" },
	["<leader>"] = {
		c = {"Comment Selection"},
		b = {"Comment Block"},
	}
}

wk.register(nmaps, {mode = 'n', noremap = true, silent = true})
wk.register(vmaps, {mode = 'v', noremap = true, silent = true})
