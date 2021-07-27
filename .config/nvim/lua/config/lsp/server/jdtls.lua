require("lspconfig").jdtls.setup {
	cmd = { vim.fn.stdpath("data") .. "/lspinstall/java/jdtls.sh" },
	on_attach = require("config.lsp.common-config").common_on_attach,
	capabilities = require("config.lsp.common-config").capabilities,
	filetypes = { "java" },
	rootPatterns = { ".git", "build.gradle", "pom.xml" }
}
