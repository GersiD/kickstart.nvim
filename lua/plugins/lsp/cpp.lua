-- Correctly setup lspconfig for clangd 🚀
return {
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'p00f/clangd_extensions.nvim' },
    opts = {
      servers = {
        -- Ensure mason installs the server
        clangd = {
          root_dir = function(fname)
            return require('lspconfig.util').root_pattern(
              'Makefile',
              'configure.ac',
              'configure.in',
              'config.h.in',
              'meson.build',
              'meson_options.txt',
              'build.ninja'
            )(fname) or require('lspconfig.util').root_pattern('compile_commands.json', 'compile_flags.txt')(
              fname
            ) or require('lspconfig.util').find_git_ancestor(fname)
          end,
          capabilities = {
            offsetEncoding = { 'utf-16' },
          },
          cmd = {
            'clangd',
            '--background-index',
            '--clang-tidy',
            '--header-insertion=iwyu',
            '--completion-style=detailed',
            '--function-arg-placeholders',
            '--fallback-style=llvm',
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },
      },
      setup = {
        clangd = function(_, opts)
          vim.api.nvim_create_autocmd('FileType', {
            desc = 'Setup CPP',
            pattern = 'cpp',
            once = true,
            callback = function()
              require('clangd_extensions').setup(vim.tbl_deep_extend('force', {}, { server = opts }))
              -- require('clangd_extensions.inlay_hints').setup_autocmd()
              -- require('clangd_extensions.inlay_hints').set_inlay_hints()
              -- vim.notify('Setup clangd extension', 'info', { title = 'LSP' })
              vim.keymap.set('n', '<leader>`', function()
                -- Save the current buffer
                vim.cmd('w')
                -- Read the compile_commands.json file in the current directory
                local compile_commands = vim.fn.json_decode(vim.fn.readfile('compile_commands.json'))
                local command = compile_commands and compile_commands[4]['run_command_custom'] or 'make'
                require('config.utils.terminals').run(command, { direction = 'horizontal' })
              end, { desc = 'Computer Graphics' })
              vim.keymap.set(
                'n',
                '<leader>lh',
                '<CMD>ClangdSwitchSourceHeader<CR>',
                { desc = 'Switch Source/Header (C/C++)' }
              )
            end,
          })
          return false
        end,
      },
    },
  },
  {
    'nvim-cmp',
    opts = function(_, opts)
      table.insert(opts.sorting.comparators, 1, require('clangd_extensions.cmp_scores'))
    end,
  },
}
