vim.api.nvim_set_keymap('n', "<TAB>", ":BufferNext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "<S-TAB>", ":BufferPrevious<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "<Leader>,", ":BufferMovePrevious<CR>", { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', "<Leader>.", ":BufferMoveNext<CR>", { noremap = true, silent = false })

vim.cmd("let bufferline = get(g:, 'bufferline', {})")
vim.cmd("let bufferline.auto_hide = v:true")
vim.cmd("let bufferline.maximum_padding = 2")
vim.cmd("let bufferline.animation = v:false")

vim.cmd("let bufferline.closable = v:false")
vim.cmd("let bufferline.clickable = v:false")

vim.cmd("let bufferline.icon_close_tab = ''")
