-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal' },
    {
      '-',
      function()
        local reveal_file = vim.fn.expand '%:p'
        if reveal_file == '' then
          reveal_file = vim.fn.getcwd()
        else
          local f = io.open(reveal_file, 'r')
          if f then
            f.close(f)
          else
            reveal_file = vim.fn.getcwd()
          end
        end
        require('neo-tree.command').execute {
          position = 'current',
          reveal_file = reveal_file,
          reveal_force_cwd = true,
        }
      end,
      { des = 'Open neo-tree at current file or working directory' },
    },
  },
  opts = {
    filesystem = {
      hijack_netrw_behavior = 'open_current',
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
