local gh = require('custom.plugins._utils').gh

vim.pack.add { gh 'dsully/treesitter-jump.nvim' }

vim.keymap.set('n', '%', function() require('treesitter-jump').jump() end, { desc = 'Jump with treesitter' })

-- vim: ts=2 sts=2 sw=2 et
