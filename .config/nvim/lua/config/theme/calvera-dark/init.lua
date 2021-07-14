-- Source
vim.cmd("packadd calvera-dark.nvim")

-- Theme
vim.g.calvera_italic_keywords = false
vim.g.calvera_italic_comments = true
vim.g.calvera_borders = true
vim.g.calvera_contrast = true
vim.g.calvera_hide_eob = true
vim.g.calvera_custom_colors = { contrast = "#0f111a" }

require("calvera").set()
