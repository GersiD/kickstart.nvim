return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    table.insert(opts.sections.lualine_x, { -- Lsp server name .
      function()
        local msg = ""
        local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
        if vim.tbl_isempty(clients) then
          return "No Active Lsp"
        end
        for ind, client in ipairs(clients) do
          if ind == 1 then
            msg = client.name
          else
            msg = msg .. " | " .. client.name
          end
        end
        return msg
      end,
      -- icon = " LSP:",
      -- color = { fg = "#ffffff", gui = "bold" },
    })
    -- fetch status of copilot_lua
    -- table.insert(opts.sections.lualine_x, {
    --   function()
    --     local client = vim.lsp.get_clients({ name = "copilot" })[1]
    --     if client == nil or vim.tbl_isempty(client.requests) then
    --       return ""
    --     end
    --
    --     local spinners = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }
    --     local ms = vim.loop.hrtime() / 1000000
    --     local frame = math.floor(ms / 120) % #spinners
    --
    --     return "" .. spinners[frame + 1]
    --     -- return ""
    --   end,
    --   color = { fg = "#2ac3de" },
    -- })
  end,
}
