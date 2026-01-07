return {
  'nvim-mini/mini.nvim', 
  version = false,
  config = function()
    -- comment out lines
    require('mini.comment').setup()
    -- produce (, {, [, etc. in pairs
    require('mini.pairs').setup()
    -- better looking status line
    require('mini.git').setup()
    require('mini.statusline').setup()
  end,
}
