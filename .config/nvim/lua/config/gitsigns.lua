require("gitsigns").setup {
	signs = {
		add          = {hl = "GitSignsAdd"   , text = '│', numhl="GitSignsAddNr"   , linehl="GitSignsAddLn"},
		change       = {hl = "GitSignsChange", text = '│', numhl="GitSignsChangeNr", linehl="GitSignsChangeLn"},
		delete       = {hl = "GitSignsDelete", text = '_', numhl="GitSignsDeleteNr", linehl="GitSignsDeleteLn"},
		topdelete    = {hl = "GitSignsDelete", text = '‾', numhl="GitSignsDeleteNr", linehl="GitSignsDeleteLn"},
		changedelete = {hl = "GitSignsChange", text = '~', numhl="GitSignsChangeNr", linehl="GitSignsChangeLn"},
	},
	numhl = false,
	linehl = false,
	keymaps = {
		noremap = true,
		buffer = true,
	},
	on_attach = function(bufnr)
		local opts = { buffer=bufnr, noremap=true, silent=true }
		local maps = {
			["<leader>g"] = {
				name = "Git",
				j = { "<cmd>lua require ('gitsigns').next_hunk()<cr>", "Next Hunk" },
				k = { "<cmd>lua require ('gitsigns').prev_hunk()<cr>", "Prev Hunk" },
				l = { "<cmd>lua require ('gitsigns').blame_line()<cr>", "Blame" },
				p = { "<cmd>lua require ('gitsigns').preview_hunk()<cr>", "Preview Hunk" },
				r = { "<cmd>lua require ('gitsigns').reset_hunk()<cr>", "Reset Hunk" },
				R = { "<cmd>lua require ('gitsigns').reset_buffer()<cr>", "Reset Buffer" },
				s = { "<cmd>lua require ('gitsigns').stage_hunk()<cr>", "Stage Hunk" },
				u = {
					"<cmd>lua require ('gitsigns').undo_stage_hunk()<cr>",
					"Undo Stage Hunk",
				},
			},
			["<leader>f"] = {
				p = { "<cmd>Telescope git_files<CR>", "Git Files" }
			}
		}
		require("which-key").register(maps, opts)
	end,
	watch_index = {
		interval = 1000
	},
	current_line_blame = false,
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
	use_decoration_api = true,
	use_internal_diff = true,  -- If luajit is present
}
