-- Initialize
local components = {
	left = {active = {}, inactive = {}},
	mid = {active = {}, inactive = {}},
	right = {active = {}, inactive = {}}
}
local properties = {
	force_inactive = {
		filetypes = {
			"NvimTree",
			"packer",
			"dbui"
		},
		buftypes = {},
		bufnames = {}
	}
}

-- Colors setup
local theme = require("config.theme."..Config.theme..".statusline_colors")
local mode_color = function()
	local mode_colors = {
		n = theme.normal,
		no = theme.normal,
		nov = theme.normal,
		noV = theme.normal,
		["no"] = theme.normal,

		t = theme.normal,
		r = theme.normal,
		rm = theme.normal,
		["r?"] = theme.normal,

		s = theme.normal,
		S = theme.normal,
		[''] = theme.normal,

		v = theme.visual,
		V = theme.visual,
		[''] = theme.visual,

		i = theme.insert,
		ic = theme.insert,
		ix = theme.insert,

		R = theme.replace,
		Rc = theme.replace,
		Rv = theme.replace,
		Rx = theme.replace,

		c = theme.command,
		cv = theme.command,
		ce = theme.command,
		['!'] = theme.command,
	}

	local color = mode_colors[vim.fn.mode()]

	if color == nil then
		color = { fg = "#fc0303", bg = "#000000" }
	end

	return color
end

-- Mode Info
table.insert(components.left.active, {
	provider = function()
		local alias = {
			n = "NORMAL",
			no = "OP PENDING",

			t = "TERMINAL",

			s = "SELECT",
			S = "S-LINE",
			[''] = "S-BLOCK",

			v = "VISUAL",
			V = "V-LINE",
			[''] = "V-BLOCK",

			i = "INSERT",
			ic = "INSERT COMPL",
			ix = "INSERT COMPL",

			R = "REPLACE",
			Rv = "V REPLACE",

			c = "COMMAND",
			cv = "VIM EX",
			ce = "EX",
			r = "PROMPT",
			rm = "MORE",
			['r?'] = "CONFIRM",
			['!'] = "SHELL",
		}
		local alias_mode = alias[vim.fn.mode()]
		if alias_mode == nil then
			alias_mode = vim.fn.mode()
		end
		return alias_mode
	end,
	left_sep = function() return { str = ' ', hl = { fg = mode_color().a.fg, bg = mode_color().a.bg, style = "bold" }} end,
	right_sep = function() return { str = ' ', hl = { fg = mode_color().a.fg, bg = mode_color().a.bg, style = "bold" }} end,
	hl = function() return { fg = mode_color().a.fg, bg = mode_color().a.bg, style = "bold" } end
})

-- Git Info
table.insert(components.left.active, {
	provider = function()
		local gsd = vim.b.gitsigns_status_dict
		if not gsd then return '' end

		local info = ""

		if gsd.head and #gsd.head > 0 then
			info = info.." "..gsd.head
		end

		if gsd.added and gsd.added > 0 then
			info = info.." +"..gsd.added
		end

		if gsd.changed and gsd.changed > 0 then
			info = info.." ~"..gsd.changed
		end

		if gsd.removed and gsd.removed > 0 then
			info = info.." -"..gsd.removed
		end

		return info
	end,
	left_sep = function() return { str = ' ', hl = mode_color().b } end,
	right_sep = function() return { str = ' ', hl = mode_color().b } end,
	enabled = function() return vim.b.gitsigns_status_dict ~= nil end,
	hl = function() return mode_color().b end
})

-- File Name
table.insert(components.left.active, {
	provider = function()
		local filename = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
		if vim.bo.modified then
			filename = filename..' '
		end
		return filename
	end,
	left_sep = function() return { str = ' ', hl = mode_color().c } end,
	right_sep = function() return { str = ' ', hl = mode_color().c } end,
	hl = function() return mode_color().c end
})

-- Lsp Server
table.insert(components.left.active, {
	provider = function()
		local clients = {}
		for _, client in pairs(vim.lsp.buf_get_clients()) do
			clients[#clients+1] = " " .. client.name
		end
		return table.concat(clients, ' ')
	end,
	enabled = function() return require("feline.providers.lsp").is_lsp_attached() end,
	left_sep = function() return { str = ' ', hl = mode_color().c } end,
	right_sep = function() return { str = ' ', hl = mode_color().c } end,
	hl = function() return mode_color().c end
})

-- Lsp Diagnostics
table.insert(components.right.active, {
	provider = function()
		return "✖ "..require("feline.providers.lsp").get_diagnostics_count("Error")
	end,
	enabled = function() return require("feline.providers.lsp").diagnostics_exist("Error") end,
	left_sep = function() return { str = ' ', hl = mode_color().c } end,
	hl = function() return { fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("LspDiagnosticsSignError")), "fg#"), bg = mode_color().c.bg } end
})
table.insert(components.right.active, {
	provider = function()
		return "❢ "..require("feline.providers.lsp").get_diagnostics_count("Warning")
	end,
	enabled = function() return require("feline.providers.lsp").diagnostics_exist("Warning") end,
	left_sep = function() return { str = ' ', hl = mode_color().c } end,
	hl = function() return { fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("LspDiagnosticsSignWarning")), "fg#"), bg = mode_color().c.bg } end
})
table.insert(components.right.active, {
	provider = function()
		return " "..require("feline.providers.lsp").get_diagnostics_count("Hint")
	end,
	enabled = function() return require("feline.providers.lsp").diagnostics_exist("Hint") end,
	left_sep = function() return { str = ' ', hl = mode_color().c } end,
	hl = function() return { fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("LspDiagnosticsSignHint")), "fg#"), bg = mode_color().c.bg } end
})
table.insert(components.right.active, {
	provider = function()
		return "● "..require("feline.providers.lsp").get_diagnostics_count("Information")
	end,
	enabled = function() return require("feline.providers.lsp").diagnostics_exist("Information") end,
	left_sep = function() return { str = ' ', hl = mode_color().c } end,
	hl = function() return { fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("LspDiagnosticsSignInformation")), "fg#"), bg = mode_color().c.bg } end
})

-- File Type
table.insert(components.right.active, {
	provider = function()
		return vim.bo.filetype:lower()
	end,
	left_sep = function() return { str = ' ', hl = mode_color().c } end,
	right_sep = function() return { str = ' ', hl = mode_color().c } end,
	hl = function() return mode_color().c end
})

-- File Info
table.insert(components.right.active, {
	provider = function()
		local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc
		return enc:lower()..'['..vim.bo.fileformat:lower()..']'
	end,
	left_sep = function() return { str = ' ', hl = mode_color().b } end,
	right_sep = function() return { str = ' ', hl = mode_color().b } end,
	hl = function() return mode_color().b end
})

-- Line Percent
table.insert(components.right.active, {
	provider = function()
		local current_line = vim.fn.line('.')
		local total_line = vim.fn.line('$')
		local result,_ = math.modf((current_line/total_line)*100)
		return result .. "%%"
	end,
	left_sep = function() return { str = ' ', hl = mode_color().a } end,
	hl = function() return mode_color().a end
})

-- Line & Column
table.insert(components.right.active, {
	provider = function()
		local line = vim.fn.line('.')
		local column = vim.fn.col('.')
		local total_line = vim.fn.line('$')
		return string.format("%d/%d :%d", line, total_line, column)
	end,
	left_sep = function() return { str = ' ', hl = mode_color().a } end,
	right_sep = function() return { str = ' ', hl = mode_color().a } end,
	hl = function() return { fg = mode_color().a.fg, bg = mode_color().a.bg, style = "bold" } end
})

-- WhiteSpace
table.insert(components.right.active, {
	provider = function()
		local ret = require("config.feline.whitespace").get_item()
		if string.len(ret) == 0 then
			return ''
		else
			return ' '..ret..' '
		end
	end,
	hl = function() return mode_color().b end
})

-- Inactive
table.insert(components.left.inactive, {
	provider = function()
		return vim.fn.expand("%:t")
	end,
	left_sep = function() return { str = ' ', hl = theme.inactive.a } end,
	right_sep = function() return { str = ' ', hl = theme.inactive.a } end,
	hl = theme.inactive.a
})

-- Setup
require("feline").setup {
	default_fg = theme.normal.c.fg,
	default_bg = theme.normal.c.bg,
	components = components,
	properties = properties
}