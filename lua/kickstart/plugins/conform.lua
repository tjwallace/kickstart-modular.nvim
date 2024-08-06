return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local filetype = vim.bo[bufnr].filetype

        -- Disable format_on_save for these filetypes
        local disable_format_on_save = { ruby = true }
        if disable_format_on_save[filetype] then
          return
        end

        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_lsp_fallback = { c = true, cpp = true }

        return {
          timeout_ms = 500,
          lsp_fallback = not disable_lsp_fallback[filetype],
        }
      end,
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
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
