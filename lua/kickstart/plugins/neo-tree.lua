-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

vim.pack.add {
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = vim.version.range '*' },
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
}

vim.keymap.set('n', '\\', '<Cmd>Neotree reveal<CR>', { desc = 'NeoTree reveal', silent = true })
vim.keymap.set('n', '-', function()
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
end, { desc = 'Open neo-tree at current file or working directory' })

vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('Neotree_start_directory', { clear = true }),
  desc = 'Start Neo-tree with directory',
  once = true,
  callback = function()
    local stats = vim.uv.fs_stat(vim.fn.argv(0))
    if stats and stats.type == 'directory' then require 'neo-tree' end
  end,
})

require('neo-tree').setup {
  filesystem = {
    hijack_netrw_behavior = 'open_current',
    bind_to_cwd = false,
    follow_current_file = { enabled = true },
    use_libuv_file_watcher = true,
    window = {
      mappings = {
        ['\\'] = 'close_window',
      },
    },
    filtered_items = {
      visible = true, -- show hidden files by default
    },
  },
}
