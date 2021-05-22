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
vim.cmd('sign define LspDiagnosticsSignError text=✖')
vim.cmd('sign define LspDiagnosticsSignWarning text=❢')
vim.cmd('sign define LspDiagnosticsSignInformation text=●')
vim.cmd('sign define LspDiagnosticsSignHint text=●')

require("lspinstall").setup()
local installed_servers = require("lspinstall").installed_servers()
local common_settings = require("config.lsp.lsp-common-config")

local configed_servers = {
	lua = function() require("config.lsp.lua-ls") end,
	cpp = function() require("config.lsp.clangd") end,
	python = function() require("config.lsp.pyright") end,
}

for _, server in pairs(installed_servers) do
	if configed_servers[server] then
		configed_servers[server]()
	else
		require("lspconfig")[server].setup {
			on_attach = common_settings.common_on_attach
		}
	end
end
