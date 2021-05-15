local vim = vim

-- Remaps
vim.cmd("nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>")
vim.cmd("nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>")
vim.cmd("nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>")
vim.cmd("nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>")
vim.cmd("nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>")
vim.cmd("nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>")
vim.cmd("nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
vim.cmd("nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>")

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
vim.cmd('sign define LspDiagnosticsSignWarning text=✖')
vim.cmd('sign define LspDiagnosticsSignInformation text=●')
vim.cmd('sign define LspDiagnosticsSignHint text=●')

require("lspinstall").setup()

local configed_servers = {
	lua = function() require("config.lsp.lua-ls") end,
	cpp = function() require("config.lsp.clangd") end,
	python = function() require("config.lsp.pyright") end,
}

local installed_servers = require("lspinstall").installed_servers()
for _, server in pairs(installed_servers) do
	if configed_servers[server] then
		configed_servers[server]()
	else
		require("lspconfig")[server].setup{}
	end
end
