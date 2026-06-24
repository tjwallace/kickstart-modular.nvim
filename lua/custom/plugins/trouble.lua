local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'folke/todo-comments.nvim',
  gh 'nvim-tree/nvim-web-devicons',
  gh 'folke/trouble.nvim',
}

require('trouble').setup { focus = true }

vim.keymap.set('n', '<leader>xw', '<cmd>Trouble diagnostics toggle<CR>', { desc = 'Open trouble workspace diagnostics' })
vim.keymap.set('n', '<leader>xd', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', { desc = 'Open trouble document diagnostics' })
vim.keymap.set('n', '<leader>xq', '<cmd>Trouble quickfix toggle<CR>', { desc = 'Open trouble quickfix list' })
vim.keymap.set('n', '<leader>xl', '<cmd>Trouble loclist toggle<CR>', { desc = 'Open trouble location list' })
vim.keymap.set('n', '<leader>xt', '<cmd>Trouble todo toggle<CR>', { desc = 'Open todos in trouble' })

-- vim: ts=2 sts=2 sw=2 et
