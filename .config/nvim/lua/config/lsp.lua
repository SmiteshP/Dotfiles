require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"clangd",
		"pyright",
		"lua_ls",
		"rust_analyzer"
	},
	automatic_installation = true,
})

-- Diagnostics symbols for display in the sign column.
vim.fn.sign_define("DiagnosticSignError", { texthl = "DiagnosticSignError", text = "✖", numhl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { texthl = "DiagnosticSignWarn", text = "❢", numhl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignHint", { texthl = "DiagnosticSignHint", text = "", numhl = "DiagnosticSignHint" })
vim.fn.sign_define("DiagnosticSignInfo", { texthl = "DiagnosticSignInfo", text = "𝓲", numhl = "DiagnosticSignInfo" })

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
			d = { "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", "Definition" },
			D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
			i = { "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>", "Implementation" },
			k = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
			h = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Help" },
			n = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
			r = { "<cmd>lua require('telescope.builtin').lsp_references()<CR>", "References" },
			l = { "<cmd>lua vim.diagnostic.open_float({scope = 'line'})<CR>", "Show Diagnostics" },
		},
		["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Prev Diagnostics" },
		["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next Diagnostics" }
	}

	require("which-key").register(maps, opts);
end

local function documentHighlight(client, bufnr)
	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		local lsp_document_highlight = vim.api.nvim_create_augroup("config_lsp_document_highlight", {clear = false})
		vim.api.nvim_clear_autocmds({
			buffer = bufnr,
			group = lsp_document_highlight
		})
		vim.api.nvim_create_autocmd(
			"CursorHold",
			{
				callback = function() vim.lsp.buf.document_highlight() end,
				group = lsp_document_highlight,
				buffer = 0
			}
		)
		vim.api.nvim_create_autocmd(
			"CursorMoved",
			{
				callback = function() vim.lsp.buf.clear_references() end,
				group = lsp_document_highlight,
				buffer = 0
			}
		)
	end
end

function common_config.common_on_attach(client, bufnr)
	key_maps(bufnr)
	local lsp_hover_augroup = vim.api.nvim_create_augroup("config_lsp_hover", {clear = false})
	vim.api.nvim_clear_autocmds({
		buffer = bufnr,
		group = lsp_hover_augroup
	})
	vim.api.nvim_create_autocmd(
		"CursorHold",
		{
			callback = function()
				for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
					if vim.api.nvim_win_get_config(winid).relative ~= "" then
						return
					end
				end
				vim.diagnostic.open_float()
			end,
			group = lsp_hover_augroup,
			buffer = bufnr
		}
	)
	if Config.lsp.highlight then
		documentHighlight(client, bufnr)
	end
	require("nvim-navic").attach(client, bufnr)
end

-- cmp-lsp capabilities
common_config.capabilities = vim.lsp.protocol.make_client_capabilities()
common_config.capabilities = require("cmp_nvim_lsp").default_capabilities(common_config.capabilities)

-- Handlers
vim.lsp.handlers['workspace/diagnostic/refresh'] = function(_, _, ctx)
  local ns = vim.lsp.diagnostic.get_namespace(ctx.client_id)
  local bufnr = vim.api.nvim_get_current_buf()
  vim.diagnostic.reset(ns, bufnr)
  return true
end

-- Diagnostics config
vim.diagnostic.config({
	underline = true,
	virtual_text = false,
	signs = true,
	update_in_insert = false,
	float = {
		scope = "cursor",
		border = "single",
		header = "",
		prefix = "",
		focusable = false
	}
})

-- Setup Servers
require("lspconfig").clangd.setup {
	cmd = { "clangd" , "--background-index", "--cross-file-rename", "--header-insertion=never" },
	on_attach = common_config.common_on_attach,
	capabilities = common_config.capabilities,
	filetypes = { "c", "cpp", "objc" },
	rootPatterns = { ".git", "compile_flags.txt", "compile_commands.json" },
}

require("lspconfig").jdtls.setup {
	on_attach = common_config.common_on_attach,
	capabilities = common_config.capabilities,
	filetypes = { "java" },
	rootPatterns = { ".git", "build.gradle", "pom.xml" }
}

require("lspconfig").pyright.setup {
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

require("lspconfig").lua_ls.setup {
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

require("lspconfig").html.setup {
	on_attach = common_config.common_on_attach,
	capabilities = common_config.capabilities
}

return common_config
