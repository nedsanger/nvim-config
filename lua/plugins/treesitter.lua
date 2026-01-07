return {
  'nvim-treesitter/nvim-treesitter',
  opts = {
    ensure_installed = { 'bash', 'c', 'diff', 'haskell', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'python', 'query', 'rust', 'vim', 'vimdoc' },
    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = {
      enable = true,
    },
    indent = {
      enable = true, 
      disable = { 'ruby' }
    },
  },
  build = ':TSUpdate',
}
