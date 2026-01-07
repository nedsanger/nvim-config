return {
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  opts = {
    -- delay between pressing a key and opening which-key (milliseconds)
    delay = 250,

    spec = {
      -- suggestions for Telescope
      { '<leader>s', group = '[S]earch' },
    },
  },
}
