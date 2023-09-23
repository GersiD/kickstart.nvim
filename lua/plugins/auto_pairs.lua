return {
  -- First disable mini.pairs
  { "echasnovski/mini.pairs", enabled = false },
  {
    "windwp/nvim-autopairs",
    enabled = false,
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        disable_filetype = { "TelescopePrompt" },
      })
      -- add more custom autopairs configuration such as custom rules
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      local cond = require("nvim-autopairs.conds")
      npairs.add_rules({
        Rule("$", "$", { "tex", "latex" })
          -- don't add a pair if the next character is %
          :with_pair(cond.not_after_regex("%%"))
          -- don't add a pair if  the previous character is xxx
          :with_pair(cond.not_before_regex("xxx", 3))
          -- don't move right when repeat character
          :with_move(cond.none())
          -- don't delete if the next character is xx
          :with_del(cond.not_after_regex("xx"))
          -- disable adding a newline when you press <cr>
          :with_cr(cond.none()),
      })
    end,
  },
  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    branch = "v0.6",
    opts = {
      --Config goes here
      -- tabout = { -- *ultimate-autopair-map-tabout-config*
      --   enable = true,
      --   map = "<Tab>", --string or table
      --   cmap = "<Tab>", --string or table
      --   conf = {},
      --   --contains extension config
      --   multi = false,
      --   --use multiple configs (|ultimate-autopair-map-multi-config|)
      --   hopout = false,
      --   -- (|) > tabout > ()|
      --   do_nothing_if_fail = false,
      --   --add a module so that if close fails
      --   --then a `\t` will not be inserted
      -- },
    },
  },
}
