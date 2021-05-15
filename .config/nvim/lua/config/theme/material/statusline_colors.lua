local theme = require("lualine.themes.material-nvim")

-- kaicataldo/material.vim colors for statusline
theme.normal.a.bg = "#89ddff"
theme.insert.a.bg = "#bb80b3"
theme.visual.a.bg = "#82aaff"
theme.replace.a.bg = "#91b859"
theme.command.a.bg = theme.normal.a.bg

-- Fill in missing color definitions
theme.insert.c = theme.normal.c
theme.visual.c = theme.normal.c
theme.replace.c = theme.normal.c
theme.command.c = theme.normal.c

-- Invert section a for minimal look
--[[
theme.normal.a.bg, theme.normal.a.fg = theme.normal.a.fg, theme.normal.a.bg
theme.insert.a.bg, theme.insert.a.fg = theme.insert.a.fg, theme.insert.a.bg
theme.visual.a.bg, theme.visual.a.fg = theme.visual.a.fg, theme.visual.a.bg
theme.replace.a.bg, theme.replace.a.fg = theme.replace.a.fg, theme.replace.a.bg
theme.command.a.bg, theme.command.a.fg = theme.command.a.fg, theme.command.a.bg
--]]

return theme
