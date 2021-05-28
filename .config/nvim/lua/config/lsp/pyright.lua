local common_settings = require("config.lsp.lsp-common-config")

require("lspconfig").pyright.setup {
	filetypes = { "python" },
	on_attach = common_settings.common_on_attach,
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
