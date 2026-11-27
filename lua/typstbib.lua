-- automate the generation of a bibliography in typst
-- but using pandoc, which has superior CSL parsing
--
-- per-project config: a `typstbib.json` in the project (found by searching
-- upward from the current file). paths are relative to that file:
--
--   {
--     "bib": "aux/references.bib",     -- required
--     "output": "aux/bib.typ",         -- required
--     "csl": "aux/bibstyle.csl",       -- optional
--     "template": "aux/template.typ",  -- optional
--     "metadata": "aux/metadata.yaml", -- optional
--     "main": "thesis.typ",            -- optional, default: current file
--     "auto": true                     -- optional, rebuild on save
--   }

local M = {}

local CONFIG_NAME = "typstbib.json"
local PATH_FIELDS = { "bib", "output", "csl", "template", "metadata", "main" }

local function notify(msg, level)
  vim.schedule(function()
    vim.notify("TypstBib: " .. msg, level or vim.log.levels.INFO)
  end)
end

-- find and parse the project config for buffer `buf`
local function load_config(buf)
  local file = vim.api.nvim_buf_get_name(buf)
  local path = vim.fs.find(CONFIG_NAME, { path = vim.fs.dirname(file), upward = true })[1]
  if not path then
    return nil, "no " .. CONFIG_NAME .. " found above " .. file
  end

  local ok, cfg = pcall(vim.json.decode, table.concat(vim.fn.readfile(path), "\n"))
  if not ok or type(cfg) ~= "table" then
    return nil, "could not parse " .. path
  end

  for _, field in ipairs({ "bib", "output" }) do
    if not cfg[field] then
      return nil, path .. ": missing required field '" .. field .. "'"
    end
  end

  local root = vim.fs.dirname(path)
  for _, field in ipairs(PATH_FIELDS) do
    if cfg[field] then
      cfg[field] = vim.fs.normalize(vim.fs.joinpath(root, cfg[field]))
    end
  end
  cfg.root = root
  cfg.main = cfg.main or file
  return cfg
end

-- turn the JSON list of cite keys into "@a @b ...", without duplicates
local function format_keys(json)
  local ok, list = pcall(vim.json.decode, json)
  if not ok or type(list) ~= "table" then
    return nil
  end

  local seen, keys = {}, {}
  for _, key in ipairs(list) do
    if not seen[key] then
      seen[key] = true
      table.insert(keys, "@" .. key)
    end
  end
  return table.concat(keys, " "), #keys
end

local function run_pandoc(cfg, keys, count)
  local cmd = { "pandoc", "-f", "markdown", "-t", "typst", "-C", "--bibliography", cfg.bib, "-o", cfg.output }
  if cfg.csl then
    vim.list_extend(cmd, { "--csl", cfg.csl })
  end
  if cfg.template then
    vim.list_extend(cmd, { "--template", cfg.template })
  end
  if cfg.metadata then
    vim.list_extend(cmd, { "--metadata-file", cfg.metadata })
  end

  vim.system(cmd, { text = true, stdin = keys, cwd = cfg.root }, function(res)
    if res.code ~= 0 then
      notify("pandoc failed:\n" .. res.stderr, vim.log.levels.ERROR)
    else
      notify(("wrote %d references to %s"):format(count, vim.fn.fnamemodify(cfg.output, ":~:.")))
    end
  end)
end

function M.build(buf)
  local cfg, err = load_config(buf or 0)
  if not cfg then
    notify(err, vim.log.levels.ERROR)
    return
  end

  local cmd = { "typst", "eval", "--root", cfg.root, "--in", cfg.main, "query(cite).map(it => str(it.key))" }
  vim.system(cmd, { text = true, cwd = cfg.root }, function(res)
    if res.code ~= 0 then
      notify("typst query failed:\n" .. res.stderr, vim.log.levels.ERROR)
      return
    end
    local keys, count = format_keys(res.stdout)
    if not keys then
      notify("could not parse typst query output", vim.log.levels.ERROR)
      return
    end
    run_pandoc(cfg, keys, count)
  end)
end

local group = vim.api.nvim_create_augroup("typstbib", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "typst",
  callback = function(args)
    vim.api.nvim_buf_create_user_command(args.buf, "TypstBib", function()
      M.build(args.buf)
    end, { desc = "Generate bibliography with pandoc" })

    local cfg = load_config(args.buf)
    if cfg and cfg.auto then
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = group,
        buffer = args.buf,
        callback = function()
          M.build(args.buf)
        end,
      })
    end
  end,
})

return M
