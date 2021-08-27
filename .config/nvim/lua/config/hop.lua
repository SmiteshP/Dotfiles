require("hop").setup { keys = "asdghkl;weroiutyvnbcmfj" }

vim.api.nvim_set_keymap('n', 'S', "<cmd>lua require'hop'.hint_char2()<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', 's', "<cmd>lua require'hop'.hint_words()<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('x', 'S', "<cmd>lua require'hop'.hint_char2()<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('x', 's', "<cmd>lua require'hop'.hint_words()<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('o', 'S', "<cmd>lua require'hop'.hint_char2()<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('o', 's', "<cmd>lua require'hop'.hint_words()<cr>", { silent = true, noremap = true })
