-- automate the generation of a bibliography in typst
-- but using pandoc, which has superior CSL parsing

-- globals
-- just for test purposes
local dir = "~/ucla/ma-thesis/"
local file = vim.fn.expand(dir .. "qr-complexity.typ")
local bib_path = vim.fn.expand(dir .. "aux/references.bib")
local metadata_path = vim.fn.expand(dir .. "aux/metadata.yaml")
local style_path = vim.fn.expand(dir .. "aux/bibstyle.csl")
local template_path = vim.fn.expand(dir .. "aux/template.typ")
local write_path = vim.fn.expand(dir .. "aux/bib.typ")

local function notify(msg, level)
  vim.schedule(function()
    vim.notify("typstbib: " .. msg, level or vim.log.levels.INFO)
  end)
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

local function run_pandoc(keys, count)
  local cmd = {
    "pandoc",
    "-f",
    "markdown",
    "-t",
    "typst",
    "--metadata-file",
    metadata_path,
    "-o",
    write_path,
    "-C",
    "--csl",
    style_path,
    "--bibliography",
    bib_path,
    "--template",
    template_path,
  }

  vim.system(cmd, { text = true, stdin = keys }, function(res)
    if res.code ~= 0 then
      notify("pandoc failed:\n" .. res.stderr, vim.log.levels.ERROR)
    else
      notify(("wrote %d references to %s"):format(count, vim.fn.fnamemodify(write_path, ":~:.")))
    end
  end)
end

local function build()
  local cmd = { "typst", "eval", "--in", file, "query(cite).map(it => str(it.key))" }
  vim.system(cmd, { text = true }, function(res)
    if res.code ~= 0 then
      notify("typst query failed:\n" .. res.stderr, vim.log.levels.ERROR)
      return
    end
    local keys, count = format_keys(res.stdout)
    if not keys then
      notify("could not parse typst query output", vim.log.levels.ERROR)
      return
    end
    run_pandoc(keys, count)
  end)
end

vim.api.nvim_create_user_command("TypstBib", build, { desc = "Generate bibliography with pandoc" })
