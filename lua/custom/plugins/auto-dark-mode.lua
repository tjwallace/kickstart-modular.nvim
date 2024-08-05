return {
  'f-person/auto-dark-mode.nvim',
  opts = {
    update_interval = 1000,
    set_dark_mode = function()
      vim.api.nvim_set_option_value('background', 'dark', {})
      vim.cmd.colorscheme 'tokyonight-night'
    end,
    set_light_mode = function()
      vim.api.nvim_set_option_value('background', 'light', {})
      vim.cmd.colorscheme 'tokyonight-day'
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
