local function gh(repo) return 'https://github.com/' .. repo end

-- [[ Formatting ]]
vim.pack.add { gh 'stevearc/conform.nvim' }
require('conform').setup {
  notify_on_error = false,
  format_on_save = function(bufnr)
    local filetype = vim.bo[bufnr].filetype

    -- Disable format_on_save for these filetypes
    local disable_format_on_save = { ruby = true }
    if disable_format_on_save[filetype] then return end

    -- Disable "format_on_save lsp_fallback" for languages that don't
    -- have a well standardized coding style. You can add additional
    -- languages here or re-enable it for the disabled ones.
    local disable_filetypes = { c = true, cpp = true }
    if disable_filetypes[filetype] then
      return nil
    else
      return {
        timeout_ms = 1000,
        lsp_format = 'fallback',
      }
    end
  end,
  default_format_opts = {
    lsp_format = 'fallback', -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
  },
  -- You can also specify external formatters in here.
  formatters_by_ft = {
    lua = { 'stylua' },
    ruby = { 'rubocop' },
    go = { 'goimports', 'gofmt' },
    -- Conform can also run multiple formatters sequentially
    -- python = { "isort", "black" },
    --
    -- You can use 'stop_after_first' to run the first available formatter from the list
    -- javascript = { "prettierd", "prettier", stop_after_first = true },
  },
  formatters = {
    -- force rubocop to use bundler
    rubocop = {
      command = 'bundle',
      prepend_args = { 'exec', 'rubocop' },
    },
  },
}

vim.api.nvim_create_user_command('Format', function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]

    range = {
      start = { args.line1, 0 },
      ['end'] = { args.line2, end_line:len() },
    }
  end
  require('conform').format { async = true, lsp_format = 'fallback', range = range }
end, { range = true })

vim.keymap.set({ 'n', 'v' }, '<leader>fb', function() require('conform').format { async = true, lsp_format = 'fallback' } end, { desc = '[F]ormat [b]uffer' })

-- vim: ts=2 sts=2 sw=2 et
