-- yayamlls is installed outside Mason:
--   brew install home-operations/tap/yayamlls
--
-- It still attaches in single-file mode when no root marker is found.
vim.lsp.config('yayamlls', {
  cmd = { 'yayamlls' },
  filetypes = { 'yaml' },
  root_markers = { '.yayamlls.yaml', '.git' },
})

vim.lsp.enable 'yayamlls'

-- vim: ts=2 sts=2 sw=2 et
