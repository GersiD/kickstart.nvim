-- Themes
return {
  {
    "rose-pine/neovim",
    config = function()
      require("rose-pine").setup({
        --- @usage 'auto'|'main'|'moon'|'dawn'
        variant = "moon",
        --- @usage 'main'|'moon'|'dawn'
        dark_variant = "moon",
        disable_italics = true,
      })
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    opts = {
      compile = false, -- enable compiling the colorscheme
      undercurl = true, -- enable undercurls
      commentStyle = { italic = false },
      functionStyle = { italic = false },
      keywordStyle = { italic = false },
      statementStyle = { italic = false },
      typeStyle = { italic = false },
      variableStyle = { italic = false },
      transparent = false, -- do not set background color
      dimInactive = false, -- dim inactive window `:h hl-NormalNC`
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      colors = { -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      theme = "dragon", -- Load "wave" theme when 'background' option is not set
      background = { -- map the value of 'background' option to a theme
        dark = "wave", -- try "dragon" !
        light = "lotus",
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
      -- terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
      -- no_italic = true, -- Disable italic comments, keywords, etc.
      -- transparent = true, -- Enable transparent background
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        -- comments = { italic = true },
        keywords = { italic = false },
        functions = { italic = false },
        variables = { italic = false },
        -- Background styles. Can be "dark", "transparent" or "normal"
        -- sidebars = "transparent", -- style for sidebars, see below
        -- floats = "transparent", -- style for floating windows
      },
      -- sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
      -- day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
      -- hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.

      --- You can override specific color groups to use other groups or a hex color
      --- function will be called with a ColorScheme table
      ---@param colors ColorScheme
      -- on_colors = function(colors) end,

      --- You can override specific highlights to use other groups or a hex color
      --- function will be called with a Highlights and ColorScheme table
      ---@param highlights Highlights
      ---@param colors ColorScheme
      -- on_highlights = function(highlights, colors) end,
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato",
        no_italic = true,
        integrations = {
          notify = true,
          mini = true,
          leap = true,
          aerial = true,
          telescope = true,
          fidget = true,
          flash = true,
          neotree = true,
          which_key = true,
          -- For more plugins integrations see (https://github.com/catppuccin/nvim#integrations)
        },
      })
    end,
  },
  { "EdenEast/nightfox.nvim" },
  { "sainnhe/everforest" },
  { "sainnhe/gruvbox-material" },
  { "sainnhe/edge" },
  { "projekt0n/github-nvim-theme" },
  {
    "AlexvZyl/nordic.nvim",
    opts = function()
      local palette = require("nordic.colors")
      return {
        override = {
          TelescopePromptTitle = {
            -- fg = palette.white1,
            bg = palette.green.dim,
            italic = true,
            underline = false,
            sp = palette.yellow.dim,
            undercurl = false,
          },
        },
      }
    end,
  },
  -- Set LazyVim ColorScheme
  {
    "LazyVim/LazyVim",
    opts = {
      ---@type string|fun()
      colorscheme = "catppuccin",
    },
  },
}
