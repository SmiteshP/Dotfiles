local lsp_config = {}

local key_maps = function(client, bufnr)
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

local function documentHighlight(client, bufnr)
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

function lsp_config.common_on_attach(client, bufnr)
	key_maps(client, bufnr)
	if Config.lsp.highlight then
		documentHighlight(client, bufnr)
	end
end

return lsp_config
