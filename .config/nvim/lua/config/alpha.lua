local if_nil = vim.F.if_nil

local default_header = {
	type = "text",
	val = {
		[[                                                 ]],
		[[███    ██ ███████  ██████  ██    ██ ██ ███    ███]],
		[[████   ██ ██      ██    ██ ██    ██ ██ ████  ████]],
		[[██ ██  ██ █████   ██    ██ ██    ██ ██ ██ ████ ██]],
		[[██  ██ ██ ██      ██    ██  ██  ██  ██ ██  ██  ██]],
		[[██   ████ ███████  ██████    ████   ██ ██      ██]],
		[[                                                 ]],
	},
	opts = {
		position = "center",
		hl = "Type"
	}
}

--                    req req  optional optional
local function button(sc, txt, keybind, keybind_opts)
	local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

	local opts = {
		position = "center",
		shortcut = sc,
		cursor = 5,
		width = 50,
		align_shortcut = "right",
		hl_shortcut = "Keyword",
	}
	if keybind then
		keybind_opts = if_nil(keybind_opts, {noremap = true, silent = true, nowait = true})
		opts.keymap = {"n", sc_, keybind, keybind_opts}
	end

	return {
		type = "button",
		val = txt,
		on_press = function()
			local key = vim.api.nvim_replace_termcodes(sc_ .. '<Ignore>', true, false, true)
			vim.api.nvim_feedkeys(key, "normal", false)
		end,
		opts = opts,
	}
end

local buttons = {
	type = "group",
	val = {
		button("e", "  New file", "<cmd>ene<CR>"),
		button("SPC f f", "  Find file", "<cmd>Telescope find_files<CR>"),
		button("SPC f o", "  Recently opened files", "<cmd>Telescope oldfiles<CR>"),
		button("SPC f g", "  Find word", "<cmd>Telescope live_grep<CR>"),
	},
	opts = {
		spacing = 1
	}
}

local section = {
	header = default_header,
	buttons = buttons,
}

local opts = {
	layout = {
		{type = "padding", val = 2},
		section.header,
		{type = "padding", val = 2},
		section.buttons,
	},
	opts = {
		margin = 5
	},
}

require("alpha").setup(opts)
