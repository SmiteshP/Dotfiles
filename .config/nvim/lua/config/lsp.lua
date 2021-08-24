-- Diagnostics symbols for display in the sign column.
vim.fn.sign_define("LspDiagnosticsSignError", { texthl = "LspDiagnosticsSignError", text = "✖", numhl = "LspDiagnosticsSignError" })
vim.fn.sign_define("LspDiagnosticsSignWarning", { texthl = "LspDiagnosticsSignWarning", text = "❢", numhl = "LspDiagnosticsSignWarning" })
vim.fn.sign_define("LspDiagnosticsSignHint", { texthl = "LspDiagnosticsSignHint", text = "", numhl = "LspDiagnosticsSignHint" })
vim.fn.sign_define("LspDiagnosticsSignInformation", { texthl = "LspDiagnosticsSignInformation", text = "𝓲", numhl = "LspDiagnosticsSignInformation" })

-- Common Configuration
local common_config = {}

local function key_maps(bufnr)
	--Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { buffer=bufnr, noremap=true, silent=true }

	local maps = {
		["<leader>l"] = {
			name = "Lsp",
			a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
			d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
			D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
			i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
			k = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
			h = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Help" },
			n = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
			r = { "<cmd>lua vim.lsp.buf.references()<CR>", "References" },
		},
		["[d"] = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", "Prev Diagnostics" },
		["]d"] = { "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Next Diagnostics" }
	}

	require("which-key").register(maps, opts);
end

local function documentHighlight(client)
	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec(
		[[
			augroup lsp_document_highlight
			autocmd! * <buffer>
			autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
			autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
			augroup END
		]],
		false
		)
	end
end

function common_config.common_on_attach(client, bufnr)
	key_maps(bufnr)
	if Config.lsp.highlight then
		documentHighlight(client)
	end
end

-- cmp-lsp capabilities
common_config.capabilities = vim.lsp.protocol.make_client_capabilities()
common_config.capabilities = require('cmp_nvim_lsp').update_capabilities(common_config.capabilities)

-- Setup Servers
require("lspconfig").clangd.setup {
	cmd = { "/usr/bin/clangd", "--background-index", "--cross-file-rename", "--header-insertion=never" },
	on_attach = common_config.common_on_attach,
	capabilities = common_config.capabilities,
	filetypes = { "c", "cpp", "objc" },
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

require("lspconfig").jdtls.setup {
	cmd = { "jdtls" },
	on_attach = common_config.common_on_attach,
	capabilities = common_config.capabilities,
	filetypes = { "java" },
	rootPatterns = { ".git", "build.gradle", "pom.xml" }
}

require("lspconfig").pyright.setup {
	cmd = { "/usr/bin/pyright-langserver", "--stdio" },
	on_attach = common_config.common_on_attach,
	capabilities = common_config.capabilities,
	filetypes = { "python" },
	rootPatterns = { ".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt" },
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

require("lspconfig").sumneko_lua.setup {
	cmd = { "/usr/bin/lua-language-server" },
	on_attach = common_config.common_on_attach,
	capabilities = common_config.capabilities,
	filetypes = { "lua" },
	rootPatterns = { ".git" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = vim.split(package.path, ';')
			},
			diagnostics = {
				globals = { "vim", "Config" }
			},
			workspace = {
				library = {[vim.fn.expand("$VIMRUNTIME/lua")] = true,
				[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true},
				maxPreload = 10000
			},
			telemetry = {
				enable = false
			}
		}
	}
}
