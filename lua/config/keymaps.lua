-- h/t kickstart.nvim
-- https://github.com/nvim-lua/kickstart.nvim

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

-- write buffer
map("n", "<leader>w", "<cmd>w<CR>")

-- exit
map("n", "<leader>xc", "<cmd>qa<CR>")

-- clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- keybinds to make split navigation easier.
--  use CTRL+<hjkl> to switch between windows
--
--  see `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
