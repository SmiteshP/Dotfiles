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

local function has_words_before()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

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
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif vim.fn["vsnip#available"]() == 1 then
				vim.api.nvim_feedkey("<Plug>(vsnip-expand-or-jump)", "")
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.fn["vsnip#jumpable"](-1) == 1 then
				vim.api.nvim_feedkey("<Plug>(vsnip-jump-prev)", "")
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = false,
		})
	},
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
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
