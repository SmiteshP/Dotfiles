-- Source
vim.cmd("packadd tokyonight.nvim")

-- Theme
vim.g.tokyonight_style = "night"
vim.g.tokyonight_sidebars = { "terminal", "packer" }

vim.cmd[[colorscheme tokyonight]]
