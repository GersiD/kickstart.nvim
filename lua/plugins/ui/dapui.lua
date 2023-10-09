return {
  'rcarriga/nvim-dap-ui',
  -- stylua: ignore
  keys = {
    { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
    { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
  },
  config = function(_, opts)
    -- setup dap config by VsCode launch.json file
    -- require("dap.ext.vscode").load_launchjs()
    local dap = require('dap')
    local dapui = require('dapui')
    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup(opts)
    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open({})
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close({})
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close({})
    end
  end,
  opts = {
    -- Disable dap-console
    -- Set icons to characters that are more likely to work in every terminal.
    --    Feel free to remove or use ones that you like more! :)
    --    Don't feel like these are good choices.
    icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
    controls = {
      icons = {
        pause = '',
        play = '󰐌',
        step_into = '',
        step_over = '',
        step_out = '',
        step_back = '',
        run_last = '',
        terminate = '󰩈',
        disconnect = '',
      },
      enabled = true,
    },
    layouts = {
      {
        elements = {
          {
            id = 'scopes',
            size = 0.4,
          },
          {
            id = 'breakpoints',
            size = 0.1,
          },
          {
            id = 'stacks',
            size = 0.1,
          },
          {
            id = 'watches',
            size = 0.4,
          },
        },
        position = 'left',
        size = 40,
      },
      {
        elements = {
          {
            id = 'repl',
            size = 1,
          },
        },
        position = 'bottom',
        size = 15,
      },
    },
  },
}
