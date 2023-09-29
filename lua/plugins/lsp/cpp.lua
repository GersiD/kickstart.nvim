return {
  "neovim/nvim-lspconfig",
  opts = {
    setup = {
      clangd = function(_, opts)
        opts.capabilities.offsetEncoding = { "utf-16" }
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
          pattern = { "*.cpp", "*.hpp" },
          desc = "Setup C++ LSP",
          callback = function()
            vim.keymap.set("n", "<leader>`", function()
              -- Save the current buffer
              vim.cmd("w")
              -- Read the compile_commands.json file in the current directory
              local compile_commands = vim.fn.json_decode(vim.fn.readfile("compile_commands.json"))
              local command = compile_commands and compile_commands[4]["run_command_custom"] or "make"
              require("config.utils.terminals").run(command, { direction = "horizontal" })
            end, { desc = "Computer Graphics" })
          end,
        })
      end,
    },
  },
}
