local cmp = require("cmp")

-- lsp symbols for autocomplete
local icons = {
	Class = '',
	Color = '',
	Constant = '',
	Constructor = '',
	Enum = '',
	EnumMember = '',
	Event = '',
	Field = '',
	File = '',
	Folder = '',
	Function = '',
	Interface = '',
	Keyword = '',
	Method = '',
	Module = '',
	Operator = '',
	Property = '',
	Reference = '',
	Snippet = '',
	Struct = '',
	Text = '',
	TypeParameter = '',
	Unit = '',
	Value = '',
	Variable = '',
}

local sources = {
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	vsnip = "[Vsnip]",
	path = "[Path]",
}

local kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(kinds) do
	kinds[i] = icons[kind] or kind
	icons[kind] = icons[kind].." ("..kind..")"
end

-- cmp config
vim.opt.shortmess:append('c')

cmp.setup {
	completion = {
		completeopt = "menu,menuone,noselect"
	},
	documentation = {
		border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' }
	},
	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = icons[vim_item.kind]
			vim_item.menu = sources[entry.source.name]
			return vim_item
		end
	},
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<Tab>"] = function(fallback)
			if vim.fn.pumvisible() == 1 then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-n>", true, true, true), 'n')
			elseif vim.fn["vsnip#available"]() == 1 then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(vsnip-expand-or-jump)", true, true, true), '')
			else
				fallback()
			end
		end,
		["<S-Tab>"] = function(fallback)
			if vim.fn.pumvisible() == 1 then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-p>", true, true, true), 'n')
			elseif vim.fn["vsnip#available"]() == 1 then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(vsnip-jump-prev)", true, true, true), '')
			else
				fallback()
			end
		end,
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		})
	},
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "vsnip" },
	}
}
