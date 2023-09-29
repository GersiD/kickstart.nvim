vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.jl",
  desc = "Setup Julia",
  callback = function()
    vim.keymap.set("n", "<leader>`", function()
      require("config.utils.terminals").run("julia" .. " " .. vim.fn.expand("%"))
    end, { desc = "Run Julia File" })
    -- require("null-ls").register({})
  end,
})

return {}
