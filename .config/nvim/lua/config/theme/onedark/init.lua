-- Source
vim.cmd("packadd onedark.nvim")

-- Theme
vim.g.onedark_italic_comments = true
vim.g.onedark_sidebars = { "NvimTree", "terminal", "packer" }

vim.cmd[[colorscheme onedark]]
