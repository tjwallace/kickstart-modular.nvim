-- Update plugins from a command instead of `:lua vim.pack.update()`.
--  With no arguments, updates all plugins; pass plugin names to update
--  only those. Use `:PackUpdate!` to force the update.
vim.api.nvim_create_user_command('PackUpdate', function(opts)
  local names = #opts.fargs > 0 and opts.fargs or nil
  vim.pack.update(names, { force = opts.bang })
end, {
  nargs = '*',
  bang = true,
  desc = 'Update vim.pack plugins',
  complete = function(arg_lead)
    local names = vim.tbl_map(function(plugin) return plugin.spec.name end, vim.pack.get())
    return vim.tbl_filter(function(name) return name:find(arg_lead, 1, true) == 1 end, names)
  end,
})

-- vim: ts=2 sts=2 sw=2 et
