-- Solargraph is a Ruby language server (completion, go-to-definition, docs).
--
-- It is installed outside Mason. Install it one of these ways:
--   gem install solargraph                  # global (used by the cmd below)
--   bundle add solargraph --group development
--
-- If you prefer to run the version pinned in a project's Gemfile (like the
-- rubocop LSP does), swap the cmd for:
--   cmd = { 'bundle', 'exec', 'solargraph', 'stdio' },
vim.lsp.config('solargraph', {
  cmd = { 'solargraph', 'stdio' },
  filetypes = { 'ruby' },
  root_markers = { 'Gemfile', '.git' },
})

vim.lsp.enable 'solargraph'

-- vim: ts=2 sts=2 sw=2 et
