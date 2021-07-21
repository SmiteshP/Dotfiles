require("lspconfig").clangd.setup {
	cmd = {
		vim.fn.stdpath("data") .. "/lspinstall/cpp/clangd/bin/clangd",
		"--background-index", "--cross-file-rename", "--header-insertion=never"
	},
	on_attach = require("config.lsp.common-config").common_on_attach,
	filetypes = { "c", "cpp", "h", "hpp", "objc" },
	rootPatterns = { ".git", "compile_flags.txt", "compile_commands.json" },
	handlers = {
		["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
			virtual_text = true,
			signs = true,
			underline = true,
			update_in_insert = false,
		}),
	},
}
