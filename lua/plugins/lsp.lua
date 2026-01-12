-- h/t kickstart.nvim
-- https://github.com/nvim-lua/kickstart.nvim

return {
  {
    "neovim/nvim-lspconfig",

    dependencies = {
      "saghen/blink.cmp",
    },

    config = function()
      vim.lsp.config("*", {
        root_markers = { ".git" },
      })

      local servers = {
        "pyright",
        "hls",
        "lua_ls",
        "rust_analyzer",
        "texlab",
        "tinymist",
        "ocamllsp",
      }
      vim.lsp.config["tinymist"] = {
        cmd = { "tinymist" },
        filetypes = { "typst" },
        -- make the LSP's workspace the same as the
        -- directory of the current file. this could
        -- produce weird results in a project with
        -- multiple directories
        root_dir = function(bufnr, on_dir)
          local path = vim.api.nvim_buf_get_name(bufnr)
          on_dir(vim.fs.dirname(path))
        end,
        settings = {
          semanticTokens = "disable",
        },
      }
      vim.lsp.config["hls"] = {
        filetypes = { "haskell", "lhaskell", "cabal" },
        root_markers = { "*.cabal" },
      }
      vim.lsp.enable(servers)

      vim.diagnostic.config({
        virtual_text = false, -- removes inline diagnostic text
        virtual_lines = { current_line = true }, -- show diagnostics for the current line
        underline = false, -- removes squiggly underlines
        signs = true, -- keep gutter signs (optional)
        -- update_in_insert = false,
      })
    end,
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "tinymist",
        "hls",
        "lua_ls",
        "rust_analyzer",
        "stylua",
        "tinymist",
        "ocamllsp",
      },
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },

  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim APIs
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- xoad luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
