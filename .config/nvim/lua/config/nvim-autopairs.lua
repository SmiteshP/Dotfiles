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

require("nvim-autopairs.completion.compe").setup({
	map_cr = true, --  map <CR> on insert mode
	map_complete = true -- it will auto insert `(` after select function or method item
})

-- Add spaces in between brackets
npairs.add_rules {
	Rule(' ', ' ')
	:with_pair(function(opts)
		local pair = opts.line:sub(opts.col, opts.col + 1)
		return vim.tbl_contains({ '()', '[]', '{}' }, pair)
	end)
}

-- FIXME: Treesitter rules don't work if nvim-tree installed (Why?)
--[[
require("nvim-treesitter.configs").setup {
	autopairs = { enable = true }
}

npairs.add_rules({
	-- FIXME: inserts > even for <= places (ts_conds not working?)
	Rule("<", ">", "cpp")
		:with_pair(ts_conds.is_ts_node({"template_argument_list"}))
		:with_move(function(opts) return cond.move_right() and opts.char ~= '<' end)
})
--]]
