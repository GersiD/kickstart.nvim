return {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  event = "BufReadPre",
  config = function()
    vim.diagnostic.config({
      underline = true,
      virtual_text = false,
    })
    require("lsp_lines").setup()
  end,
}
