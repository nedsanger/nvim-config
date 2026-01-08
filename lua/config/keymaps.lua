-- h/t kickstart.nvim
-- https://github.com/nvim-lua/kickstart.nvim

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

-- write buffer
map("n", "<leader>w", "<cmd>w<CR>", { desc = "[W]rite buffer" })
map("n", "<leader>wq", "<cmd>wq<CR>", { desc = "[W]rite and [Q]uit buffer" })

-- quit
map("n", "<leader>qq", "<cmd>qa<CR>", { desc = "[Q]uit Neovim" })

-- clear highlights on search when pressing <Esc> in normal mode
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Remove search highlights" })

-- CTRL+c to yank buffer
map("n", "<C-c>", "<cmd>%yank<CR>", { desc = "Yank buffer" })

map("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })

-- toggle floating terminal
map({ "n", "t" }, "<C-\\>", "<cmd>ToggleTerm direction=float<CR>")

-- comments
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- navigate quickfix
map("n", "<M-j>", "<cmd>cnext<CR>", { desc = "Next diagnostic" })
map("n", "<M-k>", "<cmd>cprev<CR>", { desc = "Previous diagnostic" })

-- curly quotes, dashes
map("i", "<M-[>", "“")
map("i", "<M-S-[>", "”")
map("i", "<M-S-->", "—")
map("i", "<M-->", "–")

-- keybinds to make split navigation easier.
--  use CTRL+<hjkl> to switch between windows
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- run lua
map("n", "<space><space>x", "<cmd>source %<CR>")
map("n", "<space>x", ":.lua<CR>")
map("v", "<space>x", ":lua<CR>")

-- see `:help telescope.builtin`
local builtin = require("telescope.builtin")
map("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
map("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
map("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
map("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
map("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
map("n", "<leader>sp", function()
  builtin.find_files({
    cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
  })
end, { desc = "[S]earch [P]ackages" })
map("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
map("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
map("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
map("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
map("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

map("n", "<leader>s/", function()
  builtin.live_grep({
    grep_open_files = true,
    prompt_title = "Live Grep in Open Files",
  })
end, { desc = "[S]earch [/] in Open Files" })

-- shortcut for searching Neovim configuration files
map("n", "<leader>sn", function()
  builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })

-- change the nvim-tree root to the directory of the current buffer
map("n", "<leader>cd", function()
  local path = vim.api.nvim_buf_get_name(0)
  if path == "" then
    return
  end
  local directory = vim.fs.dirname(path)
  require("nvim-tree.api").tree.change_root(directory)
end)

-- nvimtree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "[N]vimtree toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "Nvimtree focus window" })
