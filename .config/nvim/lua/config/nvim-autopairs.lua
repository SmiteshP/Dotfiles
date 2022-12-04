local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
local ts_conds = require("nvim-autopairs.ts-conds")
local cond = require("nvim-autopairs.conds")

npairs.setup({
	check_ts = true,
	ts_config = {
		lua = { "string" }, -- it will not add pair on that treesitter node
	}
})

-- Add spaces in between brackets
npairs.add_rules {
	Rule(' ', ' ')
	:with_pair(function(opts)
		local pair = opts.line:sub(opts.col, opts.col + 1)
		return vim.tbl_contains({ '()', '[]', '{}' }, pair)
	end)
}
