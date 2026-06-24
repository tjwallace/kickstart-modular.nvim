local gh = require('custom.plugins._utils').gh

vim.pack.add { gh 'akinsho/bufferline.nvim' }

require('bufferline').setup {
  options = {
    mode = 'tabs',
    separator_style = 'slant',
  },
}

-- vim: ts=2 sts=2 sw=2 et
