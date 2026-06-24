local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'akinsho/bufferline.nvim',
  gh 'nvim-tree/nvim-web-devicons',
}

require('bufferline').setup {
  options = {
    mode = 'tabs',
    separator_style = 'slant',
  },
}

-- vim: ts=2 sts=2 sw=2 et
