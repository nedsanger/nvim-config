local function my_on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- if the current node is a file, open it in a window
  -- if it is a directory, make it the root node
  local function my_open_node()
    local current_node = api.tree.get_node_under_cursor()
    local type = current_node.type

    if type == "directory" or type == "link" then
      api.tree.change_root_to_node(current_node)
    elseif type == "file" then
      api.node.open.edit(current_node)
    end
  end

  -- custom mappings
  vim.keymap.set("n", "<CR>", my_open_node, opts("Open"))
  vim.keymap.set("n", "g.", api.tree.toggle_hidden_filter, opts("Toggle Filter: Dotfiles"))
end

return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      on_attach = my_on_attach,
      filters = { dotfiles = true },
      git = { enable = false },
    })
  end,
}
