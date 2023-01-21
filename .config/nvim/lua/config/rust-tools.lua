local rt = require("rust-tools")
local common_config = require("config.lsp")

rt.setup({
	tools = {
		reload_workspace_from_cargo_toml = true,
		inlay_hints = {
			auto = true,
			only_current_line = false,
			show_parameter_hints = true,
			parameter_hints_prefix = "<- ",
			other_hints_prefix = "=> ",
			max_len_align = false,
			max_len_align_padding = 1,
			right_align = false,
			right_align_padding = 7,
			highlight = "Comment",
		},
		hover_actions = {
			border = "single",
			max_width = nil,
			max_height = nil,
			auto_focus = false,
		},
	},
	server = {
		on_attach = common_config.common_on_attach,
		capabilities = common_config.capabilities,
		filetypes = { "rust" },
	},
})
