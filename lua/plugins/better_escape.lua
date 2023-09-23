return {
  "max397574/better-escape.nvim",
  event = "InsertEnter",
  config = function()
    require("better_escape").setup({
      -- defaults
      mapping = { "jk", "jj", "kj" },
      -- timeout = vim.o.timeoutlen,
      -- clear_empty_lines = true,
      -- keys = "<Esc>",
    })
  end,
}
