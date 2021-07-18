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
		requires = {
			"kyazdani42/nvim-web-devicons",
			opt = true
		},
		config = [[require("config.galaxyline")]]
	}

	-- Bufferline
	use {
		"akinsho/nvim-bufferline.lua",
		requires = {
			"kyazdani42/nvim-web-devicons",
			opt = true
		},
		config = [[require("config.nvim-bufferline")]]
	}

	-- Git Stuff
	use {
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = [[require("config.gitsigns")]]
	}

	-- LSP and other goodies
	use {
		"neovim/nvim-lspconfig",
		requires = { "kabouzeid/nvim-lspinstall" },
		config = [[require("config.lsp")]]
	}
	use {
		"hrsh7th/nvim-compe",
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
		config = [[require("config.nvim-comment")]]
	}

	-- Nvim tree
	use {
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons",
			opt = true
		},
		config = [[require("config.nvim-tree")]]
	}

	-- Telescope
	use {
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				run = "make"
			}
		},
		config = [[require("config.telescope")]]
	}

	-- Which Key
	use {
		"folke/which-key.nvim",
		config = [[require("config.which-key")]]
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
	display = {
		open_cmd = 'vnew \\[packer\\]',
	},
	profile = {
		enable = false
	}
}})

return plugins
