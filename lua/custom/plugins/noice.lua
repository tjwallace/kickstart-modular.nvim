local gh = require('custom.plugins._utils').gh

vim.pack.add {
  gh 'MunifTanjim/nui.nvim',
  gh 'rcarriga/nvim-notify',
  gh 'folke/noice.nvim',
}

require('noice').setup {
  lsp = {
    -- Override markdown rendering so that Noice uses Treesitter.
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
    },
  },
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
}

-- vim: ts=2 sts=2 sw=2 et
