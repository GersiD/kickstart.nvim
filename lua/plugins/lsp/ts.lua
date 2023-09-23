vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "*.ts",
  desc = "TS LSP User Autocommand",
  callback = function()
    require("null-ls").register({
      -- require("null-ls").builtins.formatting.black,
      -- require("null-ls").builtins.formatting.autopep8,
      -- require("null-ls").builtins.formatting.yapf,
    })

    -- Python Specific Keymaps
    -- run current file in terminal
    vim.keymap.set("n", "<leader>`", function()
      require("config.utils.terminals").run("tsc " .. vim.fn.expand("%") .. "; node " .. vim.fn.expand("%:r") .. ".js")
    end, { desc = "Run TS File" })
  end,
})

return {}
