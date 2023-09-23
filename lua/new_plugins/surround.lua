return {
  {
    "kylechui/nvim-surround",
    keys = { "s", "d", "c" },
    ---@type user_options The user options.
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      move_cursor = false,
      keymaps = {
        normal = "s",
        visual = "s",
      },
      aliases = {
        ["s"] = "]", -- Square brackets
        ["p"] = ")", -- Paren
        ["b"] = "}", -- Brackets
        ["q"] = '"', -- Quotes
        ["m"] = "$", -- Math (latex)
      },
      highlight = {
        duration = 0,
      },
    },
  },
  {
    "echasnovski/mini.surround",
    enabled = false,
    opts = {
      mappings = {
        add = "s",
        delete = "ds",
        find = "sf",
        find_left = "sF",
        highlight = "sh",
        replace = "rs",
        update_n_lines = "gsn",
      },
      silent = true,
    },
  },
}
