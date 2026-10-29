-- automate the generation of a bibliography in typst
-- but using pandoc, which has superior CSL parsing

-- globals
-- just for test purposes
local dir = "~/ucla/ma-thesis/"
local file = vim.fn.expand(dir .. "qr-complexity.typ")
local bib_path = vim.fn.expand(dir .. "references.bib")
local metadata_path = vim.fn.expand(dir .. "metadata.yaml")
local style_path = vim.fn.expand(dir .. "bibstyle.csl")
local template_path = vim.fn.expand(dir .. "template.typ")
local write_path = vim.fn.expand(dir .. "bib.typ")

local get_keys = function(cb)
  local cmd = { "typst", "query", file, "cite", "--field", "key" }

  vim.system(cmd, { text = true }, function(out)
    if out.code ~= 0 then
      cb(nil, out.stderr)
      return
    end
    cb(out.stdout)
  end)
end

local function format_keys(s)
  local ok, arr = pcall(vim.json.decode, s)
  if not ok or type(arr) ~= "table" then
    return nil
  end

  return table.concat(
    vim.tbl_map(function(k)
      return "@" .. k:gsub("[<>]", "")
    end, arr),
    ""
  )
end

local function run_pandoc(keys)
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
      print(res.stderr)
    end
  end)
end

vim.api.nvim_create_user_command("GetKeys", function()
  get_keys(function(ks)
    print(ks)
  end)
end, {})

vim.api.nvim_create_user_command("TypstBib", function()
  get_keys(function(ks)
    local formatted_keys = format_keys(ks)
    run_pandoc(formatted_keys)
  end)
end, {})
