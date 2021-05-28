local common_settings = require("config.lsp.lsp-common-config")

require("lspconfig").clangd.setup {
	on_attach = common_settings.common_on_attach,
	filetypes = { "c", "cpp", "objc", "objcpp" },
	rootPatterns = { "compile_flags.txt", "compile_commands.json" }
}
