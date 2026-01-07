-- h/t kickstart.nvim
-- https://github.com/nvim-lua/kickstart.nvim

-- highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Briefly highlight yanked text',
  callback = function()
    vim.hl.on_yank()
  end,
})
