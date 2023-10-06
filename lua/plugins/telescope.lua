return {
  'nvim-telescope/telescope.nvim',
  keys = {
    {
      '<leader>ft',
      function()
        local themes = require('plugins.themes')
        for _, theme in ipairs(themes) do
          local name = theme.name and theme.name or string.match(theme[1], '([^/]+)$')
          require('lazy').load({ plugins = name })
        end
        require('telescope.builtin').colorscheme({ treesitter = false, enable_preview = true })
      end,
      desc = 'Find themes',
    },
    { '<leader>fk', '<cmd>Telescope keymaps<cr>', desc = 'Find Keymaps' },
    {
      '<leader>r',
      '<cmd>lua require("telescope.builtin").commands(require("telescope.themes").get_ivy()) <cr>',
      desc = 'Find Commands',
    },

    { '<leader>fv', '<cmd>lua require("telescope.builtin").vim_options()<cr>', desc = 'Find vim opts' },
    {
      '<leader>ff',
      '<cmd>lua require("telescope.builtin").find_files({ hidden = true, no_ignore = true })<cr>',
      desc = 'Find all files',
    },

    { '<leader>fH', '<cmd>Telescope highlights<cr>', desc = 'Find Highlights' },
    { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Find Help' },
    {
      '<leader>fw',
      '<cmd>lua require("telescope.builtin").live_grep({additional_args = function(args)return vim.list_extend(args, { "--hidden", "--no-ignore" })end,})<cr>',
      desc = 'Find words',
    },

    { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Find Buffers' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      enabled = true,
      build = 'make',
      config = function()
        require('telescope').load_extension('fzf')
      end,
    },
  },
  cmd = 'Telescope',
  opts = function()
    return {
      defaults = {
        sorting_strategy = 'ascending',
        layout_config = {
          horizontal = {

            prompt_position = 'top',
            preview_width = 0.55,
          },
          width = 0.9,
          height = 0.9,
          preview_cutoff = 120,
        },
        mappings = {
          i = {
            ['<c-j>'] = require('telescope.actions').move_selection_next,
            ['<c-k>'] = require('telescope.actions').move_selection_previous,
          },
          n = {
            ['q'] = require('telescope.actions').close,
            ['v'] = require('telescope.actions').select_vertical,
            ['h'] = require('telescope.actions').select_horizontal,
            ['t'] = require('telescope.actions').select_tab,
          },
        },
        preview = {
          treesitter = false,
        },
        treesitter = false,
      },
      extensions = {
        fzf = {
          --     -- These are the defaults
          --     -- fuzzy = true, -- false will only do exact matching
          --     -- override_generic_sorter = true, -- override the generic sorter
          --     -- override_file_sorter = true, -- override the file sorter
          --     -- case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          --     -- -- the default case_mode is "smart_case"
        },
      },
    }
  end,
}
