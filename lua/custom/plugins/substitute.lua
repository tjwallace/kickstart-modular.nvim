local gh = require('custom.plugins._utils').gh

vim.pack.add { gh 'gbprod/substitute.nvim' }

local substitute = require 'substitute'
substitute.setup()

vim.keymap.set('n', 's', substitute.operator, { desc = 'Substitute with motion' })
vim.keymap.set('n', 'ss', substitute.line, { desc = 'Substitute line' })
vim.keymap.set('n', 'S', substitute.eol, { desc = 'Substitute to end of line' })
vim.keymap.set('x', 's', substitute.visual, { desc = 'Substitute in visual mode' })

-- vim: ts=2 sts=2 sw=2 et
