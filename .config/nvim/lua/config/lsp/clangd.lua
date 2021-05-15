require("lspconfig").clangd.setup {
	on_attach = require("config.lsp.lsp-common-config").common_on_attach,
	filetypes = { "c", "cpp", "objc", "objcpp" },
	rootPatterns = { "compile_flags.txt", "compile_commands.json" }
}
