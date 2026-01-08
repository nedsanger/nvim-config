return {
  "nvim-mini/mini.nvim",
  version = false,
  config = function()
    -- comment out lines
    require("mini.comment").setup()
    -- easily move chunks of code
    require("mini.move").setup()
    -- produce (, {, [, etc. in pairs
    require("mini.pairs").setup()
    -- better looking status line
    require("mini.git").setup()
    require("mini.statusline").setup({
      content = {
        active = function()
          local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
          local git = MiniStatusline.section_git({ trunc_width = 40 })
          local diff = MiniStatusline.section_diff({ trunc_width = 75 })
          local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
          local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
          local filename = MiniStatusline.section_filename({ trunc_width = 140 })
          local fileinfo = vim.bo.filetype
          local location = MiniStatusline.section_location({ trunc_width = 75 })
          local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

          return MiniStatusline.combine_groups({
            { hl = mode_hl, strings = { mode } },
            { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
            "%<", -- Mark general truncate point
            { hl = "MiniStatuslineFilename", strings = { filename } },
            "%=", -- End left alignment
            { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
            { hl = mode_hl, strings = { search, location } },
          })
        end,
      },
    })
    -- use only HEAD name as summary string
    local format_summary = function(data)
      -- Utilize buffer-local table summary
      local summary = vim.b[data.buf].minigit_summary
      vim.b[data.buf].minigit_summary_string = summary.head_name or ""
    end

    local au_opts = { pattern = "MiniGitUpdated", callback = format_summary }
    vim.api.nvim_create_autocmd("User", au_opts)

    -- surround commands
    require("mini.surround").setup()
  end,
}
