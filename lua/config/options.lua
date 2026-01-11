-- h/t kickstart.nvim
-- https://github.com/nvim-lua/kickstart.nvim

local o = vim.o
local opt = vim.opt

-- show line numbers
o.number = true

-- enable mouse mode: useful for resizing splits
o.mouse = "a"

-- don't show the mode, since it's already in the status line
o.showmode = false

-- sync clipboard between OS and Neovim
--  schedule the setting after `UiEnter` because it can increase startup-time
--  remove this option if you want your OS clipboard to remain independent
--  see `:help 'clipboard'`
vim.schedule(function()
  o.clipboard = "unnamedplus"
end)

-- enable break indent
o.breakindent = true

-- save undo history
o.undofile = true

-- case-insensitive searching UNLESS \C or one or more capital letters in the search term
o.ignorecase = true
o.smartcase = true

-- keep signcolumn on by default
o.signcolumn = "yes:1"

-- decrease update time
o.updatetime = 250

-- decrease mapped sequence wait time
o.timeoutlen = 400

-- configure how new splits should be opened
o.splitright = true
o.splitbelow = true

-- sets how neovim will display certain whitespace characters in the editor
--  see `:help 'list'`
--  and `:help 'listchars'`
--
--  notice listchars is set using `opt` instead of `vim.o`
--  it is very similar to `o` but offers an interface for conveniently interacting with tables
--   see `:help lua-options`
--   and `:help lua-options-guide`
o.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- preview substitutions live, as you type!
o.inccommand = "split"

-- show which line your cursor is on
o.cursorline = true

-- minimal number of screen lines to keep above and below the cursor.
o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
o.confirm = true

-- rounded edges for floating windows
o.winborder = "rounded"

-- use four spaces to indent
o.shiftwidth = 4

-- syntax concealment
o.conceallevel = 2
