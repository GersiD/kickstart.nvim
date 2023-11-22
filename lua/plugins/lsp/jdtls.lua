-- Java
-- Utility function to extend or override a config table, similar to the way
-- that Plugin.opts works.
-- NOTE: jdtls version 1.27.1 is required for this to work.
return {
  'mfussenegger/nvim-jdtls', -- load jdtls on module
  ft = { 'java' },
  config = function()
    -- Find the extra bundles that should be passed on the jdtls command-line
    -- if nvim-dap is enabled with java debug/test.
    local mason_registry = require('mason-registry')
    local bundles = {} ---@type string[]
    if mason_registry.is_installed('java-debug-adapter') then
      local java_dbg_pkg = mason_registry.get_package('java-debug-adapter')
      local java_dbg_path = java_dbg_pkg:get_install_path()
      local jar_patterns = {
        java_dbg_path .. '/extension/server/com.microsoft.java.debug.plugin-*.jar',
      }
      -- java-test also depends on java-debug-adapter.
      if mason_registry.is_installed('java-test') then
        local java_test_pkg = mason_registry.get_package('java-test')
        local java_test_path = java_test_pkg:get_install_path()
        vim.list_extend(jar_patterns, {
          java_test_path .. '/extension/server/*.jar',
        })
      end
      for _, jar_pattern in ipairs(jar_patterns) do
        for _, bundle in ipairs(vim.split(vim.fn.glob(jar_pattern), '\n')) do
          table.insert(bundles, bundle)
        end
      end
    end

    local opts = {
      cmd = { 'jdtls' },
      root_dir = require('jdtls.setup').find_root({ 'build.gradle.kts', '.git', '.gradle', 'gradle.properties' }),
      -- enable CMP capabilities
      capabilities = require('cmp_nvim_lsp').default_capabilities(),
      project_name = function(root_dir)
        return root_dir and vim.fs.basename(root_dir)
      end,
      init_options = {
        bundles = bundles,
      },
      -- These depend on nvim-dap, but can additionally be disabled by setting false here.
      dap = { hotcodereplace = 'auto', config_overrides = {} },
      test = true,
    }

    local function attach_jdtls()
      -- Existing server will be reused if the root_dir matches.
      require('jdtls').start_or_attach(opts)
      -- not need to require("jdtls.setup").add_commands(), start automatically adds commands
    end

    -- Attach the jdtls for each java buffer. HOWEVER, this plugin loads
    -- depending on filetype, so this autocmd doesn't run for the first file.
    -- For that, we call directly below.
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'java' },
      callback = attach_jdtls,
    })

    -- Setup keymap and dap after the lsp is fully attached.
    -- https://github.com/mfussenegger/nvim-jdtls#nvim-dap-configuration
    -- https://neovim.io/doc/user/lsp.html#LspAttach
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == 'jdtls' then
          vim.keymap.set('n', '<leader><esc>', function()
            require('config.utils.terminals').run('gradle test')
          end, { desc = 'Gradle Test' })
          local wk = require('which-key')
          wk.register({
            ['<leader>lx'] = { name = '+extract' },
            ['<leader>lxv'] = { require('jdtls').extract_variable_all, 'Extract Variable' },
            ['<leader>lxc'] = { require('jdtls').extract_constant, 'Extract Constant' },
            -- ['gs'] = { require('jdtls').extract_constant, 'Goto Super' },
            ['gS'] = { require('jdtls.tests').goto_subjects, 'Goto Subjects' },
            ['<leader>lo'] = { require('jdtls').organize_imports, 'Organize Imports' },
          }, { mode = 'n', buffer = args.buf })
          wk.register({
            ['<leader>l'] = { name = '+LSP' },
            ['<leader>lx'] = { name = '+extract' },
            ['<leader>lxm'] = {
              [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
              'Extract Method',
            },
            ['<leader>lxv'] = {
              [[<ESC><CMD>lua require('jdtls').extract_variable_all(true)<CR>]],
              'Extract Variable',
            },
            ['<leader>lxc'] = {
              [[<ESC><CMD>lua require('jdtls').extract_constant(true)<CR>]],
              'Extract Constant',
            },
          }, { mode = 'v', buffer = args.buf })

          if mason_registry.is_installed('java-debug-adapter') then
            -- custom init for Java debugger
            require('jdtls').setup_dap(opts.dap)
            require('jdtls.dap').setup_dap_main_class_configs()

            -- Java Test require Java debugger to work
            if mason_registry.is_installed('java-test') then
              -- custom keymaps for Java test runner (not yet compatible with neotest)
              wk.register({
                ['<leader>t'] = { name = '+test' },
                ['<leader>tt'] = { require('jdtls.dap').test_class, 'Run All Test' },
                ['<leader>tr'] = { require('jdtls.dap').test_nearest_method, 'Run Nearest Test' },
                ['<leader>tT'] = { require('jdtls.dap').pick_test, 'Run Test' },
              }, { mode = 'n', buffer = args.buf })
            end
          end
        end
      end,
    })

    -- Avoid race condition by calling attach the first time, since the autocmd won't fire.
    attach_jdtls()
  end,
}
