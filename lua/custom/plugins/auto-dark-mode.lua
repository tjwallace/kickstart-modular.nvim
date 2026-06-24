local gh = require('custom.plugins._utils').gh

vim.pack.add { gh 'f-person/auto-dark-mode.nvim' }

require('auto-dark-mode').setup {
  update_interval = 1000,
  set_dark_mode = function() vim.cmd.colorscheme 'tokyonight-storm' end,
  set_light_mode = function() vim.cmd.colorscheme 'tokyonight-day' end,
}

-- vim: ts=2 sts=2 sw=2 et
