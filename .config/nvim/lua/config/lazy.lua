local lazy = require("lazy")

local plugins = {
	-- Lazy
	{ "folke/lazy.nvim" },

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("config.nvim-treesitter")
		end
	},

	-- Status line
	{
		"feline-nvim/feline.nvim",
		dependencies = {
			"kyazdani42/nvim-web-devicons",
			"lewis6991/gitsigns.nvim",
			"SmiteshP/nvim-navic"
		},
		config = function()
			require("config.feline")
		end
	},
	{
		"SmiteshP/nvim-navic",
		dependencies = {
			"neovim/nvim-lspconfig"
		},
		config = function()
			require("config.nvim-navic")
		end
	},

	-- Bufferline
	{
		"akinsho/bufferline.nvim",
		dependencies = {
			"kyazdani42/nvim-web-devicons"
		},
		config = function()
			require("config.bufferline")
		end
	},

	-- Git Stuff
	{
		"lewis6991/gitsigns.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim"
		},
		config = function()
			require("config.gitsigns")
		end
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"SmiteshP/nvim-navbuddy"
		},
		config = function()
			require("config.lsp")
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		dependencies = {
			"mason.nvim"
		}
	},
	{
		"williamboman/mason.nvim",
		build = function()
			pcall(function()
				require("mason-registry").refresh()
			end)
		end
	},
	{
		"simrat39/rust-tools.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			require("config.rust-tools")
		end
	},
	{
		"SmiteshP/nvim-navbuddy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"neovim/nvim-lspconfig",
			"SmiteshP/nvim-navic"
		},
		config = function()
			require("config.nvim-navbuddy")
		end
	},

	-- Completion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip"
		},
		config = function()
			require("config.nvim-cmp")
		end
	},

	-- Autopairs
	{
		"windwp/nvim-autopairs",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"hrsh7th/nvim-cmp"
		},
		config = function()
			require("config.nvim-autopairs")
		end
	},

	-- Comments
	{
		"numToStr/Comment.nvim",
		keys = {
			{ "<leader>c", mode = {'n', 'v'}},
			{ "<leader>b", mode = {'n', 'v'}},
		},
		config = function()
			require("config.comment")
		end
	},

	-- Nvim tree
	{
		"kyazdani42/nvim-tree.lua",
		cmd = "NvimTreeToggle",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("config.nvim-tree")
		end
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make"
			}
		},
		config = function()
			require("config.telescope")
		end
	},

	-- Which Key
	{
		"folke/which-key.nvim",
		config = function()
			require("config.which-key")
		end
	},

	-- Terminal
	{
		"akinsho/nvim-toggleterm.lua",
		cmd = { "ToggleTerm", "TermExec" },
		keys = { { "<c-\\><c-\\>", mode = 'n' } },
		config = function()
			require("config.nvim-toggleterm")
		end
	},

	-- Hop
	{
		"phaazon/hop.nvim",
		config = function()
			require("config.hop")
		end
	},

	-- Startup
	{
		"goolord/alpha-nvim",
		config = function()
			require("config.alpha")
		end
	},

	-- Colorschemes
	{
		"marko-cerovac/material.nvim",
		priority = 1000,
		lazy = Config.theme ~= "material",
		config = function()
			require("config.theme.material")
		end
	},
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		lazy = Config.theme ~= "tokyonight",
		config = function()
			require("config.theme.tokyonight")
		end
	},
	{
		"eddyekofo94/gruvbox-flat.nvim",
		priority = 1000,
		lazy = Config.theme ~= "gruvbox",
		config = function()
			require("config.theme.gruvbox")
		end
	},
	{
		"sainnhe/gruvbox-material",
		priority = 1000,
		lazy = Config.theme ~= "gruvbox-material",
		config = function()
			require("config.theme.gruvbox-material")
		end
	},
	{
		"monsonjeremy/onedark.nvim",
		priority = 1000,
		lazy = Config.theme ~= "onedark",
		config = function()
			require("config.theme.onedark")
		end
	},
	{
		"yashguptaz/calvera-dark.nvim",
		priority = 1000,
		lazy = Config.theme ~= "calvera-dark",
		config = function()
			require("config.theme.calvera-dark")
		end
	},
	{
		"Pocco81/Catppuccino.nvim",
		priority = 1000,
		lazy = Config.theme ~= "catppuccino",
		config = function()
			require("config.theme.catppuccino")
		end
	},
}

local opts = {
	ui = {
		size = { width = 0.9, height = 0.8 },
		border = "single"
	},
	dev = {
		path = "~/GeneralCoding/vim-plugins",
		patterns = {"SmiteshP"},
		fallback = true
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"netrwPlugin",
				"tohtml",
				"man",
				"tarPlugin",
				"zipPlugin",
				"gzip"
			}
		}
	}
}

lazy.setup(plugins, opts)
