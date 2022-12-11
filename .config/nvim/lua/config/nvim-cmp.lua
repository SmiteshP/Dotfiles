local cmp = require("cmp")
local luasnip = require("luasnip")

-- lsp symbols for autocomplete
local icons = {
	Text = '',
	Method = '',
	Function = '',
	Constructor = '',
	Field = '',
	Variable = '',
	Class = '',
	Interface = '',
	Module = '',
	Property = '',
	Unit = '',
	Value = '',
	Enum = '',
	Keyword = '',
	Snippet = '',
	Color = '',
	File = '',
	Reference = '',
	Folder = '',
	EnumMember = '',
	Constant = '',
	Struct = '',
	Event = '',
	Operator = '',
	TypeParameter = '',
}

local sources = {
	path = "[Path]",
	nvim_lua = "[Lua]",
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	vsnip = "[Vsnip]",
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
	window = {
		documentation = {
			border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' }
		}
	},
	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = icons[vim_item.kind]
			vim_item.menu = sources[entry.source.name]
			return vim_item
		end
	},
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if luasnip.expand_or_jumpable() then
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "", true)
			else
				fallback()
			end
		end, { 'i', 's' }),
		["<S-Tab>"] = cmp.mapping(function(_)
			luasnip.jump(-1)
		end, { 'i', 's' }),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = false,
		})
	},
	preselect = cmp.PreselectMode.None,
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = {
		{ name = "path" },
		{ name = "nvim_lua" },
		{ name = "nvim_lsp" },
		{ name = 'nvim_lsp_signature_help' },
		{ name = "buffer" },
		{ name = "vsnip" },
	}
}

cmp.setup.cmdline('/', {
	mapping = cmp.mapping.preset.cmdline(),
	formatting = {
		format = function(_, vim_item)
			vim_item.kind = ''
			return vim_item
		end
	},
	sources = {
		{ name = 'buffer' }
	}
})

cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	formatting = {
		format = function(_, vim_item)
			vim_item.kind = ''
			return vim_item
		end
	},
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})
