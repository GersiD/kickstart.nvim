return {
  'folke/which-key.nvim',
  lazy = false,
  opts = {
    plugins = { spelling = true },
    defaults = {
      mode = { 'n', 'v' },
      ['g'] = { name = '+goto' },
      ['gz'] = { name = '+surround' },
      [']'] = { name = '+next' },
      ['['] = { name = '+prev' },
      ['<leader>b'] = { name = '+buffer' },
      ['<leader>l'] = { name = '+code' },
      ['<leader>f'] = { name = '+file/find' },
      ['<leader>g'] = { name = '+git' },
      ['<leader>s'] = { name = '+search' },
      ['<leader>u'] = { name = '+ui' },
      ['<leader>w'] = { name = '+windows' },
      ['<leader>x'] = { name = '+diagnostics/quickfix' },
      ['<leader>p'] = { name = '+packages' },
    },
  },
  config = function(_, opts)
    local wk = require('which-key')
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}
