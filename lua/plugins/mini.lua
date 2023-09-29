return {
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    dependencies = { "folke/which-key.nvim", "nvim-treesitter-textobjects" },
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        },
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)
      -- register all text objects with which-key
      ---@type table<string, string|table>
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyLoad",
        callback = function()
          local i = {
            [" "] = "Whitespace",
            ['"'] = 'Balanced "',
            ["'"] = "Balanced '",
            ["`"] = "Balanced `",
            ["("] = "Balanced (",
            [")"] = "Balanced ) including white-space",
            [">"] = "Balanced > including white-space",
            ["<lt>"] = "Balanced <",
            ["]"] = "Balanced ] including white-space",
            ["["] = "Balanced [",
            ["}"] = "Balanced } including white-space",
            ["{"] = "Balanced {",
            ["?"] = "User Prompt",
            _ = "Underscore",
            a = "Argument",
            b = "Balanced ), ], }",
            c = "Class",
            f = "Function",
            o = "Block, conditional, loop",
            q = "Quote `, \", '",
            t = "Tag",
          }
          local a = vim.deepcopy(i)
          for k, v in pairs(a) do
            a[k] = v:gsub(" including.*", "")
          end

          local ic = vim.deepcopy(i)
          local ac = vim.deepcopy(a)
          for key, name in pairs({ n = "Next", l = "Last" }) do
            i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " textobject" }, ic)
            a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " textobject" }, ac)
          end
          require("which-key").register({
            mode = { "o", "x" },
            i = i,
            a = a,
          })
        end,
      })
    end,
  },
  { "nvim-treesitter/nvim-treesitter-textobjects", dependencies = "nvim-treesitter/nvim-treesitter" },
  keys = {
    { "a", mode = { "x", "o" } },
    { "i", mode = { "x", "o" } },
    { "[" },
    { "]" },
  },
  {
    "echasnovski/mini.bufremove",
		-- stylua: ignore
		event = "VeryLazy",
    keys = {
      {
        "<leader>bd",
        function()
          require("mini.bufremove").delete(0, true)
        end,
        desc = "Delete Buffer",
      },
    },
  },
}
