local actions = require("telescope.actions")

require("telescope").setup {
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
		path_display = { "absolute" },
		winblend = 0,
		border = {},
		borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
		color_devicons = true,
		use_less = true,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},

		-- Developer configurations: Not meant for general override
		buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
	},
	pickers = {
		buffers = {
			sort_lastused = true,
			theme = "dropdown",
			previewer = false,
			borderchars = {
				prompt =  { '─', '│', ' ', '│', '┌', '┐', '│', '│' },
				results = { '─', '│', '─', '│', '├', '┤', '┘', '└' },
			},
			mappings = {
				i = {
					["<c-d>"] = require("telescope.actions").delete_buffer,
				}
			}
		}
	},
	extensions = {
		fzf = {
			override_generic_sorter = true,  -- override the generic sorter
			override_file_sorter = true,     -- override the file sorter
			case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
		}
	}
}

require("telescope").load_extension("fzf")
