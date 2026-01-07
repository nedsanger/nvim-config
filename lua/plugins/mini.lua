return {
  'nvim-mini/mini.nvim', 
  version = false,
  config = function()
    -- better looking status line
    require('mini.statusline').setup()
    require('mini.git').setup()
  end,
}
