return {
  "Julian/lean.nvim",
  event = { "BufReadPre *.lean", "BufNewFile *.lean" },

  -- optional dependencies:
  -- 'nvim-telescope/telescope.nvim', -- for Lean-specific pickers
  -- 'andymass/vim-matchup',          -- for enhanced % motion behavior
  -- 'andrewradev/switch.vim',        -- for switch support
  -- 'tomtom/tcomment_vim',           -- for commenting

  -- set in `init` (before the plugin loads) so options read at load time apply
  init = function()
    ---@type lean.Config
    vim.g.lean_config = {
      mappings = true,
    }
  end,
}
