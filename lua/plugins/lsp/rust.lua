require("lspconfig.server_configurations.rust_analyzer").default_config.settings = {
  ["rust-analyzer"] = {
    assist = {
      importGranularity = "module",
      importPrefix = "by_self",
    },
    check = {
      command = "clippy",
      features = "all",
    },
    cargo = {
      features = "all",
    },
    procMacro = { -- What does this do?
      enable = true,
    },
  },
}

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "*.rs",
  desc = "Setup Rust LSP",
  callback = function(ev)
    vim.keymap.set("n", "<leader>`", function()
      require("config.utils.terminals").run("time cargo run", { direction = "horizontal" })
    end, { desc = "Run Rust Proj" })
    vim.keymap.set("n", "<leader>lt", function()
      require("config.utils.terminals").run("time cargo test")
    end, { desc = "LSP Test" })
    require("null-ls").register({
      require("null-ls").builtins.formatting.rustfmt,
    })
    -- set timout to nil
    require("null-ls.config").get().default_timeout = 10000
  end,
})

return {
  "simrat39/rust-tools.nvim",
  ft = { "rust", "rs" },
  opts = function()
    local rt = require("rust-tools")
    return {
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set("n", "K", "<cmd>RustHoverActions<cr>", { desc = "RUSTT", buffer = bufnr })
          vim.keymap.set("n", "<leader>la", rt.code_action_group.code_action_group, { desc = "LARSS", buffer = bufnr })
        end,
      },
      runnables = {
        use_telescope = true,
      },
      tools = {
        runnables = {
          use_telescope = true,
        },
      },
    }
  end,
}
