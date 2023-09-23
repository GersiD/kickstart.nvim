return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    "hrsh7th/cmp-emoji",
  },
  event = "VimEnter",
  opts = function(_)
    local cmp = require("cmp")
    local other_mappings = cmp.mapping.preset.cmdline({
      ["<C-j>"] = {
        c = function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
          else
            fallback()
          end
        end,
      },
      ["<C-k>"] = {
        c = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end,
      },
      ["<CR>"] = {
        c = function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true })
          else
            fallback()
          end
        end,
      },
    })
    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    ---@diagnostic disable-next-line: missing-fields
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = other_mappings,
      sources = {
        { name = "buffer" },
      },
    })
    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    ---@diagnostic disable-next-line: missing-fields
    cmp.setup.cmdline(":", {
      mapping = other_mappings,
      sources = cmp.config.sources({
        { name = "cmdline" },
      }),
    })
    return {
    completion = {
    completeopt = "menu,menuone,preview,longest",
    },
          snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
    window = {
      completion = cmp.config.window.bordered({}),
      documentation = cmp.config.window.bordered({}),
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
    }),
    -- Only use buffer source if LSP is not available (e.g. inside a string context)
  sources = cmp.config.sources({
      { name = "nvim_lsp", priority = 100 },
      { name = "luasnip", priority = 90 },
      { name = "emoji" },
    }, {
      { name = "buffer" },
    }),
    formatting = {
      -- fields = { "kind", "abbr", "menu" },
      -- fields = { "abbr", "menu", "kind" },
      expandable_indicator = false,
      fields = { "abbr", "kind", "menu" },
      -- format = function(_, item)
      --   local icons = require("lazyvim.config").icons.kinds
      --   if icons[item.kind] then
      --     item.menu = item.kind
      --     item.kind = icons[item.kind]
      --   end
      --   return item
      -- end,
    },
    experimental = {
      ghost_text = false,
    }
    }
  end,
}
