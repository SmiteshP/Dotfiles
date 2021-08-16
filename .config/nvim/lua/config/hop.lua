require("hop").setup { keys = "asdghkl;weroiutyvnbcmfj" }

vim.api.nvim_set_keymap('', 's', "<cmd>lua require'hop'.hint_char2()<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('', 'S', "<cmd>lua require'hop'.hint_words()<cr>", { silent = true, noremap = true })
