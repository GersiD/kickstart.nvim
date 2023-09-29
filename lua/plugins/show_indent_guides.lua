return {
  -- Add indentation guides even on blank lines
  'lukas-reineke/indent-blankline.nvim',
  -- Enable `lukas-reineke/indent-blankline.nvim`
  -- See `:help indent_blankline.txt`
  event = { 'BufReadPre', 'BufNewFile' },
  main = 'ibl',
  opts = {
    indent = { char = '│' },
    scope = { enabled = false },
    show_current_context = true,
    -- show_trailing_blankline_indent = false,
  },
}
