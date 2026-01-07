-- h/t kickstart.nvim
-- https://github.com/nvim-lua/kickstart.nvim

-- highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Briefly highlight yanked text',
  callback = function()
    vim.hl.on_yank()
  end,
})

-- autostart treesitter when a parser is installed
vim.api.nvim_create_autocmd("FileType", {
  desc = "Autostart treesitter",
	pattern = "*",
	callback = function()
		local filetype = vim.bo.filetype
		if filetype and filetype ~= "" then
			pcall(vim.treesitter.start)
		end
	end,
})
