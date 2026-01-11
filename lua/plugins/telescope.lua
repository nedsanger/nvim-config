return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-bibtex.nvim",

    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },

    { "nvim-tree/nvim-web-devicons", enabled = true },
  },
  config = function()
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")
    require("telescope").setup({
      extensions = {
        bibtex = {
          global_files = { "~/library/texmf/bibtex/bib/zotero.bib" },
        },
      },
    })
  end,
}
