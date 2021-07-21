require("lspconfig").sumneko_lua.setup {
	cmd = {
		vim.fn.stdpath("data") .. "/lspinstall/lua/sumneko-lua-language-server",
		"-E", vim.fn.stdpath("data") .. "/lspinstall/lua/sumneko-lua/extension/server/bin/Linux/lua-language-server"
	},
	on_attach = require("config.lsp.common-config").common_on_attach,
	filetypes = { "lua" },
	rootPatterns = { ".git" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = vim.split(package.path, ';')
			},
			diagnostics = {
				globals = { "vim", "Config" }
			},
			workspace = {
				library = {[vim.fn.expand("$VIMRUNTIME/lua")] = true,
				[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true},
				maxPreload = 10000
			},
			telemetry = {
				enable = false
			}
		}
	}
}
