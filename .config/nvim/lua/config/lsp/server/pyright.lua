require("lspconfig").pyright.setup {
	cmd = {
		vim.fn.stdpath("data") .. "/lspinstall/python/node_modules/.bin/pyright-langserver",
		"--stdio"
	},
	on_attach = require("config.lsp.common-config").common_on_attach,
	capabilities = require("config.lsp.common-config").capabilities,
	filetypes = { "python" },
	rootPatterns = { ".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt" },
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "basic",
				reportUnusedImport = true,
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "workspace",
			}
		}
	}
}
