local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'dsully/treesitter-jump.nvim' }

vim.keymap.set('n', '%', function() require('treesitter-jump').jump() end)

-- vim: ts=2 sts=2 sw=2 et
