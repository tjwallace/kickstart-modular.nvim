-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

local function gh(repo) return repo:match '^https?://' and repo or ('https://github.com/' .. repo) end

local function repo_name(repo)
  local name = repo:gsub('%.git$', ''):match '([^/]+)$' or repo
  return name:gsub('%.nvim$', ''):gsub('^nvim%-', '')
end

local function spec_repo(spec)
  if type(spec) == 'string' then return spec end
  if type(spec) == 'table' then return spec[1] or spec.src end
end

local function as_pack_spec(spec)
  local repo = spec_repo(spec)
  if not repo or repo == '' then return nil end
  if type(spec) == 'table' and spec.version then return { src = gh(repo), version = spec.version } end
  return gh(repo)
end

local function add_unique(list, seen, spec)
  local pack_spec = as_pack_spec(spec)
  if not pack_spec then return end

  local src = type(pack_spec) == 'table' and pack_spec.src or pack_spec
  if seen[src] then return end

  seen[src] = true
  table.insert(list, pack_spec)
end

local function visit_specs(specs, plugins, seen)
  for _, spec in ipairs(specs) do
    if type(spec) == 'table' and not spec[1] and not spec.src then
      visit_specs(spec, plugins, seen)
    else
      if type(spec) == 'table' and spec.dependencies then visit_specs(spec.dependencies, plugins, seen) end
      add_unique(plugins, seen, spec)
    end
  end
end

local function run_init(specs)
  for _, spec in ipairs(specs) do
    if type(spec) == 'table' and spec.init then spec.init() end
  end
end

local function infer_main(spec)
  if type(spec) ~= 'table' then return nil end
  if spec.main then return spec.main end

  local repo = spec_repo(spec)
  if not repo then return nil end
  return repo_name(repo)
end

local function setup_spec(spec)
  if type(spec) ~= 'table' or (not spec.config and spec.opts == nil) then return end

  if type(spec.config) == 'function' then
    spec.config()
    return
  end

  local main = infer_main(spec)
  if not main then return end

  local ok, mod = pcall(require, main)
  if not ok then
    vim.notify(('Unable to configure %s: %s'):format(main, mod), vim.log.levels.WARN)
    return
  end

  if type(mod.setup) == 'function' then mod.setup(spec.opts or {}) end
end

local function normalize_keys(keys)
  if not keys then return {} end
  if type(keys[1]) == 'string' then return { keys } end
  return keys
end

local function setup_keys(spec)
  if type(spec) ~= 'table' then return end

  for _, key in ipairs(normalize_keys(spec.keys)) do
    local lhs, rhs = key[1], key[2]
    if lhs and rhs then
      local opts = vim.tbl_deep_extend('force', {}, key)
      opts[1], opts[2] = nil, nil
      local mode = opts.mode or 'n'
      opts.mode = nil
      vim.keymap.set(mode, lhs, rhs, opts)
    end
  end
end

local specs = {}

-- Iterate over all Lua files in the plugins directory and load them.
local plugins_dir = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'custom', 'plugins')
for file_name, type in vim.fs.dir(plugins_dir, { follow = true }) do
  if (type == 'file' or type == 'link') and file_name:match '%.lua$' and file_name ~= 'init.lua' then
    local module = file_name:gsub('%.lua$', '')
    local spec = require('custom.plugins.' .. module)
    if spec and next(spec) ~= nil then table.insert(specs, spec) end
  end
end

run_init(specs)

local plugins = {}
visit_specs(specs, plugins, {})
vim.pack.add(plugins)

for _, spec in ipairs(specs) do
  setup_spec(spec)
  setup_keys(spec)
end

-- vim: ts=2 sts=2 sw=2 et
