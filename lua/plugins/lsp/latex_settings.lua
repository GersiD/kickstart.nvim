return {
  {
    'lervag/vimtex',
    lazy = false,
    config = function()
      vim.g.vimtex_compiler_latexmk = {
        build_dir = 'build',
        aux_dir = 'build',
        -- out_dir = "build",
      }
      vim.g.vimtex_compiler_method = 'latexmk'
      vim.g.vimtex_quickfix_open_on_warning = false
      vim.g.vimtex_quickfix_ignore_filters = { 'Underfull', 'Overfull' }
      vim.api.nvim_create_autocmd({ 'BufEnter' }, {
        pattern = '*.tex',
        desc = 'setup_omni',
        callback = function()
          -- Use omnifunc for completion
          local cmp = require('cmp')
          local sources = cmp.get_config().sources
          local addOmni = { name = 'omni', priority = 750 }
          vim.list_extend(sources, { addOmni })
          cmp.setup.buffer({ sources = sources })
        end,
      })
      if jit.os == 'Windows' then
        return {
          ['vimtex_view_general_viewer'] = 'C:/Users/gersi/AppData/Local/Microsoft/WindowsApps/SumatraPDF.exe',
          ['vimtex_view_method'] = 'C:/Users/gersi/AppData/Local/Microsoft/WindowsApps/SumatraPDF.exe',
          ['vimtex_view_general_options'] = '-reuse-instance -forward-search @tex @line @pdf',
          ['vimtex_view_general_options_latexmk'] = '-reuse-instance',
        }
      else
        return {
          ['vimtex_view_general_viewer'] = '',
          ['vimtex_view_method'] = '',
          ['vimtex_view_general_options'] = '',
          ['vimtex_view_general_options_latexmk'] = '',
        }
      end
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        texlab = {
          settings = {
            texlab = {
              chktex = {
                onEdit = false, -- default value
                onOpenAndSave = false,
              },
              latexindent = {
                modifyLineBreaks = false,
              },
              -- formatterLineLength = 10, -- doesnt work aparently
            },
          },
        },
        ltex = {
          settings = {
            ltex = { checkFrequency = 'save', language = 'en-US', diagnosticSeverity = 'info' },
          },
        },
      },
    },
  },
}
