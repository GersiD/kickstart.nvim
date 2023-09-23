return {
  "folke/flash.nvim",
  ---@type Flash.Config
  opts = {
    modes = {
      char = {
        enabled = false,
        keys = { "t", "T", ";", "," },
      },
    },
  },
  -- stylua: ignore
  keys = {
    { "s", mode = {"n", "x", "o"}, false },
    { "f", mode = {"n", "x", "o"}, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = {"n", "x", "o"}, false },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode ={ "c" }, false },
  },
}
