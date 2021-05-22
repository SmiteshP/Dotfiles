require("lspconfig").pyright.setup {
	filetypes = { "python" },
	on_attach = require("config.lsp.lsp-common-config").common_on_attach,
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
