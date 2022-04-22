local theme = require("lualine.themes.material-nvim")

-- Fill in missing color definitions
theme.insert.c = theme.normal.c
theme.visual.c = theme.normal.c
theme.replace.c = theme.normal.c
theme.command.c = theme.normal.c

-- Invert section a for minimal look
if Config.statusline.minimal then
	theme.normal.a.bg, theme.normal.a.fg = theme.normal.a.fg, theme.normal.a.bg
	theme.insert.a.bg, theme.insert.a.fg = theme.insert.a.fg, theme.insert.a.bg
	theme.visual.a.bg, theme.visual.a.fg = theme.visual.a.fg, theme.visual.a.bg
	theme.replace.a.bg, theme.replace.a.fg = theme.replace.a.fg, theme.replace.a.bg
	theme.command.a.bg, theme.command.a.fg = theme.command.a.fg, theme.command.a.bg
end

return theme
