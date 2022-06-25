local navic = require("nvim-navic")
local lsp = require("feline.providers.lsp")
local whitespace = require("config.feline.whitespace")
local devicons = require("nvim-web-devicons")

-- Initialize
local components = {
	active = {{}, {}, {}},
	inactive = {{}, {}, {}},
}

-- Colors setup
local theme = require("config.theme."..Config.theme..".statusline_colors")

local colors = {}
vim.schedule(function()
	colors.lsp_error = string.format("#%x", vim.api.nvim_get_hl_by_name("DiagnosticSignError", true).foreground)
	colors.lsp_warning = string.format("#%x", vim.api.nvim_get_hl_by_name("DiagnosticSignWarn", true).foreground)
	colors.lsp_hint = string.format("#%x", vim.api.nvim_get_hl_by_name("DiagnosticSignHint", true).foreground)
	colors.lsp_information = string.format("#%x", vim.api.nvim_get_hl_by_name("DiagnosticSignInfo", true).foreground)
end)

local mode_colors = {
	n = theme.normal,
	no = theme.normal,
	nov = theme.normal,
	noV = theme.normal,
	["no"] = theme.normal,

	niI = theme.normal,
	niR = theme.normal,
	niV = theme.normal,
	nt = theme.normal,

	v = theme.visual,
	vs = theme.visual,
	V = theme.visual,
	Vs = theme.visual,
	[''] = theme.visual,
	['s'] = theme.visual,

	s = theme.visual,
	S = theme.visual,
	[''] = theme.visual,

	i = theme.insert,
	ic = theme.insert,
	ix = theme.insert,

	R = theme.replace,
	Rc = theme.replace,
	Rx = theme.replace,
	Rv = theme.replace,
	Rvc = theme.replace,
	Rvx = theme.replace,

	c = theme.command,
	cv = theme.command,

	r = theme.normal,
	rm = theme.normal,
	["r?"] = theme.normal,
	['!'] = theme.command,
	t = theme.normal,
}

local mode_color = function()
	local color = mode_colors[vim.api.nvim_get_mode().mode]

	if color == nil then
		color = {
			a = { fg = "#fc0303", bg = "#000000" },
			b = { fg = "#fc0303", bg = "#000000" },
			c = { fg = "#fc0303", bg = "#000000" },
		}
	end

	return color
end


----- LEFT SIDE -----

-- Mode Info
local alias = {
	n = "NORMAL",
	no = "OP PENDING",
	nov = "OP PENDING CHAR",
	noV = "OP PENDING LINE",
	["no"] = "OP PENDING BLOCK",

	niI = "INSERT (NORMAL)",
	niR = "REPLACE (NORMAL)",
	niV = "V-REPLACE (NORMAL)",

	v = "VISUAL",
	vs = "VISUAL",
	V = "V-LINE",
	Vs = "V-LINE",
	[''] = "V-BLOCK",
	['s'] = "V-BLOCK",

	s = "SELECT",
	S = "S-LINE",
	[''] = "S-BLOCK",

	i = "INSERT",
	ic = "INSERT COMPL",
	ix = "INSERT COMPL",

	R = "REPLACE",
	Rc = "REPLACE",
	Rx = "REPLACE",
	Rv = "V-REPLACE",
	Rvc = "V-REPLACE",
	Rvx = "V-REPLACE",

	c = "COMMAND",
	cv = "EX",
	r = "PROMPT",
	rm = "MORE",
	['r?'] = "CONFIRM",
	['!'] = "SHELL",
	t = "TERMINAL",
}
table.insert(components.active[1], {
	provider = function()
		local alias_mode = alias[vim.api.nvim_get_mode().mode]
		if alias_mode == nil then
			alias_mode = vim.api.nvim_get_mode().mode
		end
		return alias_mode
	end,
	left_sep = function() return { str = ' ', hl = { fg = mode_color().a.fg, bg = mode_color().a.bg, style = "bold" }} end,
	right_sep = function() return { str = ' ', hl = { fg = mode_color().a.fg, bg = mode_color().a.bg, style = "bold" }} end,
	hl = function() return { fg = mode_color().a.fg, bg = mode_color().a.bg, style = "bold" } end
})

-- Git Info
table.insert(components.active[1], {
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
table.insert(components.active[1], {
	provider = function()
		local filename = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
		filename = devicons.get_icon(filename, vim.fn.expand("%:e"), { default = true } ) .. ' ' .. filename
		if vim.bo.modifiable and vim.bo.modified then
			filename = filename..' '
		end
		if vim.bo.readonly and vim.bo.filetype ~= "help" then
			filename = filename..' '
		end
		return filename
	end,
	left_sep = function() return { str = ' ', hl = mode_color().c } end,
	right_sep = function() return { str = ' ', hl = mode_color().c } end,
	hl = function() return mode_color().c end
})

-- nvim-navic
table.insert(components.active[1], {
	provider = function()
		local text = navic.get_location()
		if #text ~= 0 then
			return '> '..text
		else
			return ''
		end
	end,
	enabled = function() return navic.is_available() end,
	right_sep = function() return { str = ' ', hl = mode_color().c } end,
	hl = function() return mode_color().c end
})


----- RIGHT SIDE -----

-- Lsp Server
table.insert(components.active[3], {
	provider = " ",
	enabled = function() return next(vim.lsp.buf_get_clients()) ~= nil end,
	left_sep = function() return { str = ' ', hl = mode_color().c } end,
	hl = function() return mode_color().c end
})

-- Lsp Diagnostics
local lsp_cache = {
	error = '',
	warning = '',
	hint = '',
	information = '',
	has_error = false,
	has_warning = false,
	has_hint = false,
	has_information = false,
}
table.insert(components.active[3], {
	provider = function()
		if vim.api.nvim_get_mode().mode:byte(1) ~= string.byte('i') then
			lsp_cache.error = "✖ "..lsp.get_diagnostics_count("Error")
		end
		return lsp_cache.error
	end,
	enabled = function()
		if vim.api.nvim_get_mode().mode:byte(1) ~= string.byte('i') then
			lsp_cache.has_error = lsp.diagnostics_exist("Error")
		end
		return lsp_cache.has_error
	end,
	left_sep = function() return { str = ' ', hl = mode_color().c } end,
	hl = function() return { fg = colors.lsp_error, bg = mode_color().c.bg } end
})
table.insert(components.active[3], {
	provider = function()
		if vim.api.nvim_get_mode().mode:byte(1) ~= string.byte('i') then
			lsp_cache.warning = "❢ "..lsp.get_diagnostics_count("Warn")
		end
		return lsp_cache.warning
	end,
	enabled = function()
		if vim.api.nvim_get_mode().mode:byte(1) ~= string.byte('i') then
			lsp_cache.has_warning = lsp.diagnostics_exist("Warn")
		end
		return lsp_cache.has_warning
	end,
	left_sep = function() return { str = ' ', hl = mode_color().c } end,
	hl = function() return { fg = colors.lsp_warning, bg = mode_color().c.bg } end
})
table.insert(components.active[3], {
	provider = function()
		if vim.api.nvim_get_mode().mode:byte(1) ~= string.byte('i') then
			lsp_cache.hint = " "..lsp.get_diagnostics_count("Hint")
		end
		return lsp_cache.hint
	end,
	enabled = function()
		if vim.api.nvim_get_mode().mode:byte(1) ~= string.byte('i') then
			lsp_cache.has_hint = lsp.diagnostics_exist("Hint")
		end
		return lsp_cache.has_hint
	end,
	left_sep = function() return { str = ' ', hl = mode_color().c } end,
	hl = function() return { fg = colors.lsp_hint, bg = mode_color().c.bg } end
})
table.insert(components.active[3], {
	provider = function()
		if vim.api.nvim_get_mode().mode:byte(1) ~= string.byte('i') then
			lsp_cache.information = "𝓲 "..lsp.get_diagnostics_count("Info")
		end
		return lsp_cache.information
	end,
	enabled = function()
		if vim.api.nvim_get_mode().mode:byte(1) ~= string.byte('i') then
			lsp_cache.has_information = lsp.diagnostics_exist("Info")
		end
		return lsp_cache.has_information
	end,
	left_sep = function() return { str = ' ', hl = mode_color().c } end,
	hl = function() return { fg = colors.lsp_information, bg = mode_color().c.bg } end
})

-- File Type
table.insert(components.active[3], {
	provider = function()
		return vim.bo.filetype:lower()
	end,
	left_sep = function() return { str = ' ', hl = mode_color().c } end,
	right_sep = function() return { str = ' ', hl = mode_color().c } end,
	hl = function() return mode_color().c end
})

-- File Info
table.insert(components.active[3], {
	provider = function()
		local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc
		return enc:lower()..'['..vim.bo.fileformat:lower()..']'
	end,
	left_sep = function() return { str = ' ', hl = mode_color().b } end,
	right_sep = function() return { str = ' ', hl = mode_color().b } end,
	hl = function() return mode_color().b end
})

-- Line Percent
table.insert(components.active[3], {
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
table.insert(components.active[3], {
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
table.insert(components.active[3], {
	provider = function()
		local ret = whitespace.get_item()
		if string.len(ret) == 0 then
			return ''
		else
			return ' '..ret..' '
		end
	end,
	hl = function() return mode_color().b end
})


----- Inactive Line -----

-- Inactive
table.insert(components.inactive[1], {
	provider = function()
		return vim.fn.expand("%:t")
	end,
	left_sep = function() return { str = ' ', hl = theme.inactive.a } end,
	right_sep = function() return { str = ' ', hl = theme.inactive.a } end,
	hl = theme.inactive.a
})

-- Setup
require("feline").setup {
	colors = {
		fg = theme.normal.c.fg,
		bg = theme.normal.c.bg
	},
	components = components,
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
