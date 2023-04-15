local lualine = require("lualine")

local navic = require("nvim-navic")
local whitespace = require("config.lualine.whitespace")

local modules = require('lualine_require').lazy_require({
	loader = 'lualine.utils.loader',
})
local theme = modules.loader.load_theme("auto")

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

local lualine_a = {
	{"mode"},
}

local diff_cache = {
	added = nil,
	modified = nil,
	removed = nil
}

local lualine_b = {
	{
		"branch",
		icon = ''
	},
	{
		"diff",
		colored = true,
		padding = { left = 0, right = 1 },
		diff_color = {
			added = function()
				if diff_cache.added then
					return diff_cache.added
				else
					local ok, hl = pcall(vim.api.nvim_get_hl_by_name, "diffAdded", true)
					if ok then
						if hl.foreground then
							hl = string.format("#%x", hl.foreground)
							diff_cache.added = {fg = hl, bg = mode_color().b.bg}
						else
							diff_cache.added = mode_color().b
						end
						return diff_cache.added
					else
						return mode_color().b
					end
				end
			end,
			modified = function()
				if diff_cache.modified then
					return diff_cache.modified
				else
					local ok, hl = pcall(vim.api.nvim_get_hl_by_name, "DiffChange", true)
					if ok then
						if hl.foreground then
							hl = string.format("#%x", hl.foreground)
							diff_cache.modified = {fg = hl, bg = mode_color().b.bg}
						else
							diff_cache.modified = mode_color().b
						end
						return diff_cache.modified
					else
						return mode_color().b
					end
				end
			end,
			removed = function()
				if diff_cache.removed then
					return diff_cache.removed
				else
					local ok, hl = pcall(vim.api.nvim_get_hl_by_name, "diffRemoved", true)
					if ok then
						if hl.foreground then
							hl = string.format("#%x", hl.foreground)
							diff_cache.removed = {fg = hl, bg = mode_color().b.bg}
						else
							diff_cache.removed = mode_color().b
						end
						return diff_cache.removed
					else
						return mode_color().b
					end
				end
			end,
		},
		symbols = {added = '+', modified = '~', removed = '-'},
		source = function()
			local gsd = vim.b.gitsigns_status_dict
			if not gsd then return {} end

			local info = {}
			if gsd.added and gsd.added > 0 then
				info.added = gsd.added
			end

			if gsd.changed and gsd.changed > 0 then
				info.modified = gsd.changed
			end

			if gsd.removed and gsd.removed > 0 then
				info.removed = gsd.removed
			end

			return info
		end
	},
}

local lualine_c = {
	{
		'filetype',
		icon_only = true,
		padding = { left = 1, right = 0 }
	},
	{
		function()
			local filename = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
			if vim.bo.modifiable and vim.bo.modified then
				filename = filename..' '
			end
			if vim.bo.readonly and vim.bo.filetype ~= "help" then
				filename = filename..' '
			end
			return filename
		end,
	},
	{
		function() return navic.get_location() end,
		icon = '>',
		cond = function() return navic.is_available() end,
		padding = 0
	}
}

local lualine_x = {
	{
		function() return ' ' end,
		cond = function() return next(vim.lsp.buf_get_clients()) ~= nil end,
	},
	{
		"diagnostics",
		sources = { "nvim_diagnostic" },
		symbols = {error = '✖ ', warn = '❢ ', info = '𝓲 ', hint = ' '},
		padding = { left = 0, right = 1 }
	},
	{
		'bo:filetype',
		padding = { left = 0, right = 1 }
	},
}

local lualine_y = {
	{
		function()
			local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc
			return enc:lower()..'['..vim.bo.fileformat:lower()..']'
		end,
	}
}

local lualine_z = {
	{
		"progress",
		color = { gui = '' }
	},
	{
		function()
			local line = vim.fn.line('.')
			local column = vim.fn.col('.')
			local total_line = vim.fn.line('$')
			return string.format("%d/%d :%d", line, total_line, column)
		end,
		padding = { left = 0, right = 1 }
	},
	{
		function()
			local ret = whitespace.get_item()
			if string.len(ret) == 0 then
				return ''
			else
				return ret
			end
		end,
		color = mode_color().b
	}
}

lualine.setup({
	options = {
		section_separators = '',
		component_separators = '',
	},
	sections = {
		lualine_a = lualine_a,
		lualine_b = lualine_b,
		lualine_c = lualine_c,
		lualine_x = lualine_x,
		lualine_y = lualine_y,
		lualine_z = lualine_z
	},
})
