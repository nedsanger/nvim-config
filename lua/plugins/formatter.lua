return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      haskell = { "fourmolu" },
      lua = { "stylua" },
      tex = { "tex-fmt" },
      typst = { "typstyle" },
      ocaml = { "ocamlformat" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}
