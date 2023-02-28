require('Comment').setup({
	---Add a space b/w comment and the line
	padding = true,
	---Whether the cursor should stay at its position
	sticky = true,
	---Lines to be ignored while (un)comment
	ignore = nil,
	---LHS of toggle mappings in NORMAL mode
	toggler = {
		---Line-comment toggle keymap
		line = '<Leader>cc',
		---Block-comment toggle keymap
		block = '<Leader>bc',
	},
	---LHS of operator-pending mappings in NORMAL and VISUAL mode
	opleader = {
		---Line-comment keymap
		line = '<Leader>c',
		---Block-comment keymap
		block = '<Leader>b',
	},
	---LHS of extra mappings
	extra = {
		---Add comment on the line above
		above = '<Leader>cO',
		---Add comment on the line below
		below = '<Leader>co',
		---Add comment at the end of line
		eol = '<Leader>cA',
	},
	---Enable keybindings
	---NOTE: If given `false` then the plugin won't create any mappings
	mappings = {
		---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
		basic = true,
		---Extra mapping; `gco`, `gcO`, `gcA`
		extra = true,
	},
	---Function to call before (un)comment
	pre_hook = nil,
	---Function to call after (un)comment
	post_hook = nil,
})
