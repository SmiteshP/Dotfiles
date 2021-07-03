local actions = require("telescope.actions")

require("telescope").setup{
	defaults = {
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case"
		},
		layout_config = {
			height = 0.80,
			width = 0.80,
			prompt_position = "top",
			preview_cutoff = 120,
			horizontal = {
				mirror = false,
			},
			vertical = {
				mirror = true,
			},
		},
		prompt_prefix = "> ",
		selection_caret = "> ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		file_sorter =  require("telescope.sorters").get_fuzzy_file,
		file_ignore_patterns = { ".out" },
		generic_sorter =  require("telescope.sorters").get_generic_fuzzy_sorter,
		shorten_path = true,
		winblend = 0,
		border = {},
		borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
		color_devicons = true,
		use_less = true,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

		-- Developer configurations: Not meant for general override
		buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
		extensions = {
			fzf = {
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true,     -- override the file sorter
				case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
			}
		}
	}
}

require("telescope").load_extension("fzf")

vim.api.nvim_set_keymap('n', "<Leader>ff", ":Telescope find_files<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', "<C-p>", ":Telescope git_files<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', "<Leader>fg", ":Telescope live_grep<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', "<Leader><Tab>", ":Telescope buffers<CR>", {noremap = true, silent = true})
