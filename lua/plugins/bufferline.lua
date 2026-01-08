return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local bufferline = require("bufferline")
    bufferline.setup({
      options = {
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            separator = true,
          },
        },
        style_preset = bufferline.style_preset.no_italic,
      },
    })
  end,
}
