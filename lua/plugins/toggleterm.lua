return {
  "akinsho/toggleterm.nvim",
  cmd = "ToggleTerm",
  opts = {
    direction = "horizontal",
    float_opts = {
      border = "curved",
      highlights = { border = "Normal", background = "Normal" },
      width = 1000,
      height = 100,
    },
    -- size = 10,
    shading_factor = -10,
    -- start_in_insert = true,
    shell = "pwsh",
  },
}
