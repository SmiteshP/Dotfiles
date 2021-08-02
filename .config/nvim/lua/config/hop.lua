require("hop").setup { keys = "asdghkl;weroiutyvnbcmfj" }

vim.api.nvim_set_keymap('n', 's', "<cmd>lua require'hop'.hint_char2()<cr>", {})
vim.api.nvim_set_keymap('n', 'S', "<cmd>lua require'hop'.hint_words()<cr>", {})
