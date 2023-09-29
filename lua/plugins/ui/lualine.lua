return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  opts = function()
    local icons = require('config.icons')
    local Util = require('config.utils.fns')
    return {
      options = {
        theme = 'auto',
        globalstatus = true,
        disabled_filetypes = { statusline = { 'dashboard', 'alpha' } },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = {
          {
            'diagnostics',
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
          { 'filename', path = 1, symbols = { modified = '  ', readonly = '', unnamed = '' } },
          -- stylua: ignore
          {
            function() return require("nvim-navic").get_location() end,
            cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
          },
        },
        lualine_x = {
          -- stylua: ignore
          {
            function() return require("noice").api.status.command.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = Util.fg("Statement"),
          },
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = Util.fg("Constant"),
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = Util.fg("Debug"),
          },
          { require('lazy.status').updates, cond = require('lazy.status').has_updates, color = Util.fg('Special') },
          {
            'diff',
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
          },
        },
        lualine_y = {
          -- { 'progress', separator = ' ',                  padding = { left = 1, right = 0 } },
          -- { 'location', padding = { left = 0, right = 1 } },
          {
            function()
              local msg = ''
              local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
              if vim.tbl_isempty(clients) then
                return 'No Active Lsp'
              end
              for ind, client in ipairs(clients) do
                if ind == 1 then
                  msg = client.name
                else
                  msg = msg .. ' | ' .. client.name
                end
              end
              return msg
            end,
            -- icon = ' ',
            color = Util.fg('LspInlayHint'),
          },
        },
        lualine_z = {
          function()
            return '' .. os.date('%R')
          end,
        },
      },
      extensions = { 'neo-tree', 'lazy' },
    }
  end,
  --opts = function(_, opts)
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
  --end,
}
