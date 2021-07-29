local vim = vim

-- symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = {
	"   (Text) ",
	"   (Method)",
	"   (Function)",
	"   (Constructor)",
	"   (Field)",
	"   (Variable)",
	"   (Class)",
	"   (Interface)",
	"   (Module)",
	" 襁 (Property)",
	"   (Unit)",
	"   (Value)",
	" 練 (Enum)",
	"   (Keyword)",
	"   (Snippet)",
	"   (Color)",
	"   (File)",
	"   (Reference)",
	"   (Folder)",
	"   (EnumMember)",
	"   (Constant)",
	"   (Struct)",
	"   (Event)",
	"   (Operator)",
	"   (TypeParameter)"
}

-- Diagnostics symbols for display in the sign column.
vim.fn.sign_define("LspDiagnosticsSignError", { texthl = "LspDiagnosticsSignError", text = "✖", numhl = "LspDiagnosticsSignError" })
vim.fn.sign_define("LspDiagnosticsSignWarning", { texthl = "LspDiagnosticsSignWarning", text = "❢", numhl = "LspDiagnosticsSignWarning" })
vim.fn.sign_define("LspDiagnosticsSignHint", { texthl = "LspDiagnosticsSignHint", text = "", numhl = "LspDiagnosticsSignHint" })
vim.fn.sign_define("LspDiagnosticsSignInformation", { texthl = "LspDiagnosticsSignInformation", text = "●", numhl = "LspDiagnosticsSignInformation" })

-- Setup
require("config.lsp.server.clangd")
require("config.lsp.server.jdtls")
require("config.lsp.server.pyright")
require("config.lsp.server.sumneko_lua")
