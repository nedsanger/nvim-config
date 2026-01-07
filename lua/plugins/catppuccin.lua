return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      styles = {
	conditionals = { },
        comments = { "italic" },
      }
    })
    vim.cmd.colorscheme "catppuccin-macchiato"
  end,
}
