local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'nvim-lua/plenary.nvim',
  gh 'sindrets/diffview.nvim', -- Diff integration
  gh 'nvim-telescope/telescope.nvim',
  gh 'NeogitOrg/neogit',
}

require('neogit').setup {}

-- vim: ts=2 sts=2 sw=2 et
