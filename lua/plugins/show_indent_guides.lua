return {
  -- -- Add indentation guides even on blank lines
  {
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    event = { 'BufReadPre', 'BufNewFile' },
    main = 'ibl',
    ---@type ibl.config
    opts = {
      ---@type ibl.config.indent
      indent = { char = '│', highlight = 'IblWhitespace' },
      ---@type ibl.config.scope
      scope = {
        enabled = false,
      },
    },
  },
  {
    'echasnovski/mini.indentscope',
    version = false,
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      symbol = '│',
      options = { try_as_border = true },
    },
    config = function(_, opts)
      -- check if the highlight is set
      require('mini.indentscope').setup(opts)
    end,
  },
}
