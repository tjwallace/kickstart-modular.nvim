return {
  'f-person/auto-dark-mode.nvim',
  dependencies = {
    'folke/tokyonight.nvim',
  },
  opts = {
    update_interval = 1000,
    set_dark_mode = function()
      vim.cmd.colorscheme 'tokyonight-storm'
    end,
    set_light_mode = function()
      vim.cmd.colorscheme 'tokyonight-day'
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
