vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = '*.py',
  desc = 'Setup Python DAP',
  callback = function()
    require('null-ls').register({
      -- require("null-ls").builtins.formatting.black,
      -- require("null-ls").builtins.formatting.autopep8,
      -- require("null-ls").builtins.formatting.yapf,
    })
    -- set TSHighlight true
    vim.cmd('TSEnable highlight')

    -- Python Specific Keymaps
    -- run current file in terminal
    vim.keymap.set('n', '<leader><esc>', function()
      -- Save current file
      vim.cmd('w')
      if jit.os == 'Windows' then
        require('config.utils.terminals').run('python' .. ' ' .. vim.fn.expand('%'))
      else
        require('config.utils.terminals').run('time python3' .. ' ' .. vim.fn.expand('%'))
      end
    end, { desc = 'Run Python File' })

    vim.keymap.set('n', '<leader>lt', function()
      require('config.utils.terminals').run('pytest -v')
    end, { desc = 'Run Python Tests' })

    local dap = require('dap')
    local python_command = 'python3'
    if jit.os == 'Windows' then
      python_command = 'python'
    end
    dap.adapters.python = {
      type = 'executable',
      command = python_command,
      args = { '-m', 'debugpy.adapter' },
    }
    dap.configurations.python = {
      {
        -- The first three options are required by nvim-dap
        type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
        request = 'launch',
        name = 'Launch file',
        justMyCode = true,
        -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

        program = '${file}', -- This configuration will launch the current file if used.
        pythonPath = function()
          -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
          -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
          -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
          local cwd = vim.fn.getcwd()
          if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
            return cwd .. '/venv/bin/python'
          elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
            return cwd .. '/.venv/bin/python'
          else
            return python_command
          end
        end,
      },
    }
  end,
})

return {
  {
    'wookayin/semshi', -- use a maintained fork
    ft = 'python',
    build = ':UpdateRemotePlugins',
    enabled = false,
    init = function()
      -- Disabled these features better provided by LSP or other more general plugins
      vim.g['semshi#error_sign'] = false
      vim.g['semshi#simplify_markup'] = false
      vim.g['semshi#mark_selected_nodes'] = false
      vim.g['semshi#update_delay_factor'] = 0.001
      --
      -- This autocmd must be defined in init to take effect
      vim.api.nvim_create_autocmd({ 'VimEnter', 'ColorScheme' }, {
        group = vim.api.nvim_create_augroup('SemanticHighlight', {}),
        callback = function()
          -- Only add style, inherit or link to the LSP's colors
          vim.cmd([[
            highlight! semshiGlobal gui=italic
            highlight! link semshiImported @none
            highlight! link semshiParameter @lsp.type.parameter
            highlight! link semshiParameterUnused DiagnosticUnnecessary
            highlight! link semshiBuiltin @function.builtin
            highlight! link semshiAttribute @field
            highlight! link semshiSelf @lsp.type.selfKeyword
            highlight! link semshiUnresolved @lsp.type.unresolvedReference
            highlight! link semshiFree @none
            ]])
        end,
      })
    end,
    -- config = function() end,
  },
}
