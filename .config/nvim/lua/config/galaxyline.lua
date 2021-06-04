local vim = vim
local gl = require("galaxyline")
local condition = require("galaxyline.condition")
local vcs = require("galaxyline.provider_vcs")
local fileinfo = require("galaxyline.provider_fileinfo")
local whitespace = require("galaxyline.provider_whitespace")
local buffer = require("galaxyline.provider_buffer")
local lspclient = require("galaxyline.provider_lsp")

local gls = gl.section
gl.short_line_list = {"NvimTree", "vista", "packer"}

-- supplementary colors
local colors = {
	bg = "#282a36",
	fg = "#f8f8f2",
	section_bg = "#38393f",
	yellow = "#f1fa8c",
	cyan = "#8be9fd",
	green = "#50fa7b",
	orange = "#ffb86c",
	magenta = "#ff79c6",
	blue = "#8be9fd",
	red = "#ff5555"
}

local theme = require("config.theme."..Config.theme..".statusline_colors")

local mode_color = function(x, g)
	local mode_colors = {
		n = theme.normal[x][g],
		no = theme.normal[x][g],
		nov = theme.normal[x][g],
		noV = theme.normal[x][g],
		["no"] = theme.normal[x][g],

		t = theme.normal[x][g],
		r = theme.normal[x][g],
		rm = theme.normal[x][g],
		["r?"] = theme.normal[x][g],

		s = theme.normal[x][g],
		S = theme.normal[x][g],
		[''] = theme.normal[x][g],

		v = theme.visual[x][g],
		V = theme.visual[x][g],
		[''] = theme.visual[x][g],

		i = theme.insert[x][g],
		ic = theme.insert[x][g],
		ix = theme.insert[x][g],

		R = theme.replace[x][g],
		Rc = theme.replace[x][g],
		Rv = theme.replace[x][g],
		Rx = theme.replace[x][g],

		c = theme.command[x][g],
		cv = theme.command[x][g],
		ce = theme.command[x][g],
		['!'] = theme.command[x][g],
	}

	local color = mode_colors[vim.fn.mode()]

	if color == nil then
		color = "#fc0303"
	end

	return color
end

-- Left side
gls.left[1] = {
	ViMode = {
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
			vim.api.nvim_command("hi GalaxyViMode gui=bold guibg="..mode_color('a', "bg").." guifg="..mode_color('a', "fg"))
			local alias_mode = alias[vim.fn.mode()]
			if alias_mode == nil then
				alias_mode = vim.fn.mode()
			end
			return '⠀'..alias_mode..' '
		end,
		highlight = { theme.normal.a.fg, theme.normal.a.bg },
		separator = "",
		separator_highlight = { theme.normal.a.bg, theme.normal.b.bg }
	},
}

gls.left[2] = {
	GitIcon = {
		provider = function()
			vim.api.nvim_command("hi GalaxyGitIcon gui=bold guibg="..mode_color('b', "bg").." guifg="..mode_color('b', "fg"))
			return ''
		end,
		condition = condition.check_git_workspace,
		icon = '⠀',
	}
}

gls.left[3] = {
	GitBranch = {
		icon = '  ',
		provider = function()
			vim.api.nvim_command("hi GalaxyGitBranch guibg="..mode_color('b', "bg").." guifg="..mode_color('b', "fg"))
			return vcs.get_git_branch()
		end,
		condition = condition.check_git_workspace,
		separator = ' ',
		separator_highlight = {"NONE", theme.normal.b.bg},
		highlight = { theme.normal.b.fg, theme.normal.b.bg }
	}
}

gls.left[4] = {
	DiffAdd = {
		provider = function()
			vim.api.nvim_command("hi GalaxyDiffAdd guibg="..mode_color('b', "bg").." guifg="..mode_color('b', "fg"))
			return vcs.diff_add()
		end,
		condition = condition.hide_in_width,
		icon = '+',
		separator = '',
	}
}

gls.left[5] = {
	DiffModified = {
		provider = function()
			vim.api.nvim_command("hi GalaxyDiffModified guibg="..mode_color('b', "bg").." guifg="..mode_color('b', "fg"))
			return vcs.diff_modified()
		end,
		condition = condition.hide_in_width,
		icon = '~',
		separator = '',
	}
}

gls.left[6] = {
	DiffRemove = {
		provider = function()
			vim.api.nvim_command("hi GalaxyDiffRemove guibg="..mode_color('b', "bg").." guifg="..mode_color('b', "fg"))
			return vcs.diff_remove()
		end,
		condition = condition.hide_in_width,
		icon = '-',
		separator = '',
	}
}

gls.left[7] = {
	FileName = {
		provider = function()
			vim.api.nvim_command("hi GalaxyFileName guibg="..mode_color('c', "bg").." guifg="..mode_color('c', "fg"))
			return '⠀'..fileinfo.get_current_file_name()
		end,
		highlight = { theme.normal.c.fg, theme.normal.c.bg }
	}
}

gls.left[8] = {
	ShowLspClient = {
		provider = function()
			vim.api.nvim_command("hi GalaxyShowLspClient guibg="..mode_color('c', "bg").." guifg="..mode_color('c', "fg"))
			local lsp = lspclient.get_lsp_client()
			if lsp == "No Active Lsp" then
				return ''
			else
				return "⠀  "..lsp
			end
		end,
		condition = function()
			local tbl = {["dashboard"] = true, [' '] = true}
			if tbl[vim.bo.filetype] then return false end
			return true and condition.hide_in_width()
		end,
		highlight = {colors.grey, colors.bg}
	}
}

-- Right side
gls.right[1] = {
	DiagnosticError = {
		provider = "DiagnosticError",
		icon = "  ",
		condition = condition.hide_in_width,
		highlight = { colors.red, theme.normal.c.bg }
	}
}

gls.right[2] = {
	DiagnosticWarn = {
		provider = "DiagnosticWarn",
		icon = "  ",
		condition = condition.hide_in_width,
		highlight = { colors.orange, theme.normal.c.bg }
	}
}

gls.right[3] = {
	DiagnosticHint = {
		provider = "DiagnosticHint",
		icon = "  ",
		condition = condition.hide_in_width,
		highlight = { colors.blue, theme.normal.c.bg }
	}
}

gls.right[4] = {
	FileType = {
		provider = function()
			vim.api.nvim_command("hi GalaxyFileType guibg="..mode_color('c', "bg").." guifg="..mode_color('c', "fg"))
			return string.lower(buffer.get_buffer_filetype())..' '
		end,
		condition = condition.buffer_not_empty,
		highlight = {theme.normal.c.fg, theme.normal.c.bg},
	}
}

gls.right[5] = {
	FileEncode = {
		provider = function()
			vim.api.nvim_command("hi GalaxyFileEncode guibg="..mode_color('b', "bg").." guifg="..mode_color('b', "fg"))
			return ' '..string.lower(fileinfo.get_file_encode())
		end,
		condtion = condition.hide_in_width,
	}
}

gls.right[6] = {
	FileFormat = {
		provider = function()
			vim.api.nvim_command("hi GalaxyFileFormat guibg="..mode_color('b', "bg").." guifg="..mode_color('b', "fg"))
			return '['..string.lower(fileinfo.get_file_format()).."] "
		end,
		condtion = condition.hide_in_width,
	}
}

gls.right[7] = {
	LinePercent = {
		provider = function()
			vim.api.nvim_command("hi GalaxyLinePercent guibg="..mode_color('a', "bg").." guifg="..mode_color('a', "fg"))
			 local current_line = vim.fn.line('.')
			 local total_line = vim.fn.line('$')
			 local result,_ = math.modf((current_line/total_line)*100)
			 return '⠀'..result .. "% "
		end,
		condtion = condition.hide_in_width,
	}
}

gls.right[8] = {
	LineColumn = {
		provider = function()
			vim.api.nvim_command("hi GalaxyLineColumn gui=bold guibg="..mode_color('a', "bg").." guifg="..mode_color('a', "fg"))
			local line = vim.fn.line('.')
			local column = vim.fn.col('.')
			local total_line = vim.fn.line('$')
			return string.format("%d/%d :%d ", line, total_line, column)
		end,
		separator = '',
	}
}

gls.right[9] = {
	WhiteSpace = {
		provider = function()
			vim.api.nvim_command("hi GalaxyWhiteSpace guibg="..mode_color('b', "bg").." guifg="..mode_color('b', "fg"))
			return whitespace.get_item()
		end,
		condition = condition.hide_in_width,
	}
}

-- Short line
gls.short_line_left[1] = {
	SFileName = {
		provider = "SFileName",
		condition = condition.buffer_not_empty,
		highlight = { theme.inactive.a.fg, theme.inactive.a.bg }
	}
}

gls.short_line_right[1] = {
	SLineColumn = {
		provider = "LineColumn",
		condition = condition.buffer_not_empty,
		highlight = { theme.inactive.a.fg, theme.inactive.a.bg }
	}
}
