local install_path = vim.fn.stdpath("data").."/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	print("Downloading Packer ...")
	vim.fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
	vim.api.nvim_command("packadd packer.nvim")
	print("Packer installed, run :PackerSync")
end

local packer = require("packer")

local plugins = packer.startup({function(use)
	-- Packer
	use "wbthomason/packer.nvim"

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
		"romgrk/barbar.nvim",
		requires = {
			"kyazdani42/nvim-web-devicons",
			opt = true
		},
		config = [[require("config.barbar")]]
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

	-- Colorschemes
	use {
		"marko-cerovac/material.nvim",
		config = function() if Config_theme == "material" then require("config.theme.material") end end
	}
	use	{
		"folke/tokyonight.nvim",
		config = function() if Config_theme == "tokyonight" then require("config.theme.tokyonight") end end
	}

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
