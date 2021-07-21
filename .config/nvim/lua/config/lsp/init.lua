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
vim.cmd("sign define LspDiagnosticsSignError text=✖ texthl=LspDiagnosticsSignError linehl= numhl=")
vim.cmd("sign define LspDiagnosticsSignWarning text=❢ texthl=LspDiagnosticsSignWarning linehl= numhl=")
vim.cmd("sign define LspDiagnosticsSignInformation text=● texthl=LspDiagnosticsSignInformation linehl= numhl=")
vim.cmd("sign define LspDiagnosticsSignHint text=● texthl=LspDiagnosticsSignHint linehl= numhl=")

-- Setup
require("config.lsp.server.clangd")
require("config.lsp.server.jdtls")
require("config.lsp.server.pyright")
require("config.lsp.server.sumneko_lua")
