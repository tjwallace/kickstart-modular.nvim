return {
  'dsully/treesitter-jump.nvim',
  keys = {
    -- stylua: ignore
    { "%", function() require("treesitter-jump").jump() end },
  },
  opts = {},
}
