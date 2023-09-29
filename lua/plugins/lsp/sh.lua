vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*.sh", "*.zsh", "*.bash", "*.zshrc" },
  desc = "Setup Shell Formatter",
  callback = function()
    require("null-ls").register({
      require("null-ls").builtins.formatting.beautysh,
    })
  end,
})

return {}
