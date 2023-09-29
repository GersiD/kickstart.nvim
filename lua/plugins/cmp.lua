return {
  'hrsh7th/nvim-cmp',
  version = false,
  dependencies = {
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    {
      'rafamadriz/friendly-snippets',
      config = function()
        require('luasnip/loaders/from_vscode').lazy_load()
      end,
    },
    'hrsh7th/cmp-emoji',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'onsails/lspkind.nvim',
  },
  event = 'VimEnter',
  opts = function(_)
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    local lspkind = require('lspkind')
    local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
    end
    local other_mappings = cmp.mapping.preset.cmdline({
      ['<C-j>'] = {
        c = function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
          else
            fallback()
          end
        end,
      },
      ['<C-k>'] = {
        c = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end,
      },
      ['<CR>'] = {
        c = function(fallback)
          fallback()
        end,
      },
    })
    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    ---@diagnostic disable-next-line: missing-fields
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = other_mappings,
      completion = {
        completeopt = 'menu,menuone,preview,noinsert,noselect',
      },
      sources = {
        { name = 'buffer' },
      },
    })
    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    ---@diagnostic disable-next-line: missing-fields
    cmp.setup.cmdline(':', {
      mapping = other_mappings,
      completion = {
        completeopt = 'menu,menuone,preview,noinsert,noselect',
      },
      sources = cmp.config.sources({
        { name = 'cmdline' },
      }),
    })
    -- add () after function
    -- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    -- cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    return {
      completion = {
        completeopt = 'menu,menuone,preview,longest',
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered({}),
        documentation = cmp.config.window.bordered({}),
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- they way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),
      -- Only use buffer source if LSP is not available (e.g. inside a string context)
      sources = cmp.config.sources({
        { name = 'nvim_lsp', priority = 100 },
        { name = 'luasnip',  priority = 90 },
        { name = 'nvim_lua', priority = 80 },
        { name = 'path',     priority = 70 },
        { name = 'emoji' },
      }, {
        { name = 'buffer' },
      }),
      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        -- fields = { "abbr", "menu", "kind" },
        expandable_indicator = false,
        -- fields = { "abbr", "kind", "menu" },
        format = function(entry, vim_item)
          local kind = lspkind.cmp_format({
            symbol_map = {
              Snippet = '',
              Keyword = '',
            },
            preset = 'codicons',
            maxwidth = 50,
          })(entry, vim_item)
          local strings = vim.split(vim_item.kind, '%s+', { trimempty = true })
          kind.kind = string.format('%s │', strings[1], strings[2])
          return kind
        end,
      },
      experimental = {
        ghost_text = false,
      },
    }
  end,
}
