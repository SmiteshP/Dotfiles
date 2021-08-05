-- Source
vim.cmd("packadd onedark.nvim")

-- Theme
require("onedark").setup {
	commentStyle = "italic",
	sidebars = { "NvimTree", "terminal", "packer" }
}
