local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'MagicDuck/grug-far.nvim' }

require('grug-far').setup { headerMaxWidth = 80 }

vim.keymap.set({ 'n', 'v' }, '<leader>fr', function()
  local grug = require 'grug-far'
  local ext = vim.bo.buftype == '' and vim.fn.expand '%:e'
  grug.grug_far {
    transient = true,
    prefills = {
      filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
    },
  }
end, { desc = '[F]ind and [R]eplace' })

-- vim: ts=2 sts=2 sw=2 et
