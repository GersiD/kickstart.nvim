return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    build = ":Copilot auth",
    config = function()
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
          keymap = { accept = "<Right>" },
        },
        panel = {
          enabled = false,
        },
        filetypes = {
          markdown = true,
          help = true,
        },
      })
    end,
  },
}
