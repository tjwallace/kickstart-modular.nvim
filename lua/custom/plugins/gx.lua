vim.g.netrw_nogx = 1 -- disable netrw gx

local function open_target(target)
  if target and target ~= '' then vim.ui.open(target) end
end

vim.keymap.set('n', 'gx', function() open_target(vim.fn.expand '<cfile>') end, { desc = 'Open link or file under cursor' })

vim.keymap.set('x', 'gx', function()
  local saved_reg = vim.fn.getreg 'z'
  local saved_regtype = vim.fn.getregtype 'z'

  vim.cmd.normal { 'gv"zy', bang = true }
  open_target(vim.fn.getreg 'z')

  vim.fn.setreg('z', saved_reg, saved_regtype)
end, { desc = 'Open selected link or file' })

-- vim: ts=2 sts=2 sw=2 et
