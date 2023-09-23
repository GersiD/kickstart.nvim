return {
  "rcarriga/nvim-dap-ui",
  opts = {
    -- Disable dap-console
    layouts = {
      {
        elements = {
          {
            id = "scopes",
            size = 0.4,
          },
          {
            id = "breakpoints",
            size = 0.1,
          },
          {
            id = "stacks",
            size = 0.1,
          },
          {
            id = "watches",
            size = 0.4,
          },
        },
        position = "left",
        size = 40,
      },
      {
        elements = {
          {
            id = "repl",
            size = 1,
          },
        },
        position = "bottom",
        size = 15,
      },
    },
  },
}
