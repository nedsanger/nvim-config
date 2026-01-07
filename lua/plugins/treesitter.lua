return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    -- autoinstall languages that are not installed
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
      disable = { "ruby" },
    },
  },
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install({
      "bash",
      "c",
      "diff",
      "haskell",
      "html",
      "lua",
      "luadoc",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "rust",
      "typst",
      "vim",
      "vimdoc",
    })
  end,
}
