local packer = require("packer")

local plugins = packer.startup({function(use)
	-- Packer
	use {
		"wbthomason/packer.nvim",
		cmd = {
			"PackerClean",
			"PackerCompile",
			"PackerInstall",
			"PackerLoad",
			"PackerProfile",
			"PackerStatus",
			"PackerSync",
			"PackerUpdate"
		},
		config = [[require("config.packer")]]
	}

	-- Treesitter
	use {
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = [[require("config.nvim-treesitter")]]
	}

	-- Status line
	use {
		"glepnir/galaxyline.nvim",
		branch = "main",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = [[require("config.galaxyline")]]
	}

	-- Bufferline
	use {
		"akinsho/nvim-bufferline.lua",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = [[require("config.nvim-bufferline")]]
	}

	-- Git Stuff
	use {
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim", opt = true },
		config = [[require("config.gitsigns")]]
	}

	-- LSP
	use {
		"neovim/nvim-lspconfig",
		config = [[require("config.lsp")]]
	}

	-- Completion
	use {
		"hrsh7th/nvim-compe",
		requires = "hrsh7th/vim-vsnip",
		config = [[require("config.nvim-compe")]]
	}

	-- Autopairs
	use {
		"windwp/nvim-autopairs",
		requires = {
			"nvim-treesitter/nvim-treesitter",
			"hrsh7th/nvim-compe"
		},
		config = [[require("config.nvim-autopairs")]]
	}

	-- Comments
	use {
		"terrortylor/nvim-comment",
		keys = {
			{ 'n', "<leader>c" },
			{ 'v', "<leader>c" }
		},
		config = [[require("config.nvim-comment")]]
	}

	-- Nvim tree
	use {
		"kyazdani42/nvim-tree.lua",
		cmd = "NvimTreeToggle",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = [[require("config.nvim-tree")]]
	}

	-- Telescope
	use {
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		module = "telescope",
		requires = {
			{ "nvim-lua/popup.nvim", opt = true },
			{ "nvim-lua/plenary.nvim", opt = true },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				run = "make",
				opt = true
			}
		},
		wants = {
			"popup.nvim",
			"plenary.nvim",
			"telescope-fzf-native.nvim"
		},
		config = [[require("config.telescope")]]
	}

	-- Which Key
	use {
		"folke/which-key.nvim",
		config = [[require("config.which-key")]]
	}

	-- Terminal
	use {
		"akinsho/nvim-toggleterm.lua",
		cmd = { "ToggleTerm", "TermExec" },
		module = "toggleterm",
		keys = { { 'n', "<c-\\><c-\\>" } },
		config = [[require("config.nvim-toggleterm")]]
	}

	-- Hop
	use {
		"phaazon/hop.nvim",
		config = [[require("config.hop")]]
	}

	-- Colorschemes
	use { "marko-cerovac/material.nvim", opt = true }
	use	{ "folke/tokyonight.nvim", opt = true }
	use { "eddyekofo94/gruvbox-flat.nvim", opt = true }
	use { "monsonjeremy/onedark.nvim", opt = true }
	use { "yashguptaz/calvera-dark.nvim", opt = true }

end,
config = {
	auto_clean = true,
	compile_on_sync = true,
	ensure_dependencies = true,
	display = { open_cmd = "vnew \\[packer\\]" },
	profile = {	enable = false }
}})

return plugins
