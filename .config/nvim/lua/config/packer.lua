local packer = require("packer")

local plugins = packer.startup({function(use)
	-- Packer
	use {
		"wbthomason/packer.nvim",
		config = [[require("config.packer")]]
	}

	-- Speed Up
	use { "lewis6991/impatient.nvim" }

	-- Treesitter
	use {
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = [[require("config.nvim-treesitter")]]
	}

	-- Status line
	use {
		"feline-nvim/feline.nvim",
		requires = {
			{ "kyazdani42/nvim-web-devicons" },
			{ "lewis6991/gitsigns.nvim" },
		},
		config = [[require("config.feline")]]
	}
	use {
		"~/GeneralCoding/vim-plugins/nvim-navic",
		config = [[require("config.nvim-navic")]]
	}

	-- Bufferline
	use {
		"akinsho/bufferline.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = [[require("config.bufferline")]]
	}

	-- Git Stuff
	use {
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim", opt = true },
		config = [[require("config.gitsigns")]]
	}

	-- LSP
	use {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		config = [[require("config.lsp")]]
	}
	use {
		"simrat39/rust-tools.nvim",
		requires = { "neovim/nvim-lspconfig" },
		config = [[require("config.rust-tools")]]
	}
	use {
		"~/GeneralCoding/vim-plugins/nvim-navbuddy",
		requires = {
			"MunifTanjim/nui.nvim",
			"neovim/nvim-lspconfig"
		},
		config = [[require("config.nvim-navbuddy")]]
	}

	-- Completion
	use {
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip"
		},
		config = [[require("config.nvim-cmp")]]
	}

	-- Autopairs
	use {
		"windwp/nvim-autopairs",
		requires = {
			"nvim-treesitter/nvim-treesitter",
			"hrsh7th/nvim-cmp"
		},
		config = [[require("config.nvim-autopairs")]]
	}

	-- Comments
	use {
		"numToStr/Comment.nvim",
		keys = {
			{ 'n', "<leader>c" },
			{ 'v', "<leader>c" },
			{ 'n', "<leader>b" },
			{ 'v', "<leader>b" }
		},
		config = [[require("config.comment")]]
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

	-- Startup
	use {
		"goolord/alpha-nvim",
		config = [[require("config.alpha")]]
	}

	-- Colorschemes
	use { "marko-cerovac/material.nvim", opt = true }
	use { "folke/tokyonight.nvim", opt = true }
	use { "eddyekofo94/gruvbox-flat.nvim", opt = true, disable = true }
	use { "sainnhe/gruvbox-material", opt=true }
	use { "monsonjeremy/onedark.nvim", opt = true }
	use { "yashguptaz/calvera-dark.nvim", opt = true }
	use { "Pocco81/Catppuccino.nvim", opt = true }

end,
config = {
	auto_clean = true,
	compile_on_sync = true,
	ensure_dependencies = true,
	display = { open_cmd = "vnew \\[packer\\]" },
	profile = {	enable = false }
}})

return plugins
