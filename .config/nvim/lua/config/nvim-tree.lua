require("nvim-tree").setup {
	renderer = {
		icons = {
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true
			},
			glyphs = {
				default = '',
				symlink = '',
				git = {
					unstaged = "",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "?"
				},
				folder = {
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = ""
				}
			}
		}
	}
}
