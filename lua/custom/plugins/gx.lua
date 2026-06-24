local function gh(repo) return 'https://github.com/' .. repo end

vim.g.netrw_nogx = 1 -- disable netrw gx

vim.pack.add {
  gh 'nvim-lua/plenary.nvim',
  gh 'chrishrb/gx.nvim',
}

require('gx').setup()

vim.keymap.set({ 'n', 'x' }, 'gx', '<cmd>Browse<cr>')

-- vim: ts=2 sts=2 sw=2 et
