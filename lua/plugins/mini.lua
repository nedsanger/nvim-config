return {
  'nvim-mini/mini.nvim', 
  version = false,
  config = function()
    -- comment out lines
    require('mini.comment').setup()
    -- better looking status line
    require('mini.statusline').setup()
    require('mini.git').setup()
  end,
}
