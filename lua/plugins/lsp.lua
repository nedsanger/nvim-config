-- h/t kickstart.nvim
-- https://github.com/nvim-lua/kickstart.nvim

return {
  {
    'neovim/nvim-lspconfig',

    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      { 'saghen/blink.cmp' }
    },

    config = function()
      vim.lsp.config('*', {
        root_markers = { '.git' },
      })

      local servers = { 
        "pyright",
        "hls",
        "lua_ls",
        "rust_analyzer",
        "texlab",
        tinymist = {
          cmd = { "tinymist" },
          filetypes = { "typst" },
          settings = {
            formatterMode = "typstyle",
            exportPdf = "onType",
            semanticTokens = "disable",
          },
        }
      }
      vim.lsp.enable(servers)
      vim.lsp.config["tinymist"] = {
        cmd = { "tinymist" },
        filetypes = { "typst" },
        settings = {
          formatterMode = "typstyle",
          exportPdf = "onType",
          semanticTokens = "disable",
        },
      }

      vim.diagnostic.config {
        virtual_text = false, -- removes inline diagnostic text
        virtual_lines = { current_line = true }, -- show diagnostics for the current line
        underline = false, -- removes squiggly underlines
        signs = true, -- keep gutter signs (optional)
        -- update_in_insert = false,
      }
    end
  },

  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim APIs
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- xoad luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
}
