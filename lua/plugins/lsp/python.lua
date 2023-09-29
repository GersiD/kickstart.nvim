vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "*.py",
  desc = "Setup Python DAP",
  callback = function()
    require("null-ls").register({
      -- require("null-ls").builtins.formatting.black,
      -- require("null-ls").builtins.formatting.autopep8,
      -- require("null-ls").builtins.formatting.yapf,
    })

    -- Python Specific Keymaps
    -- run current file in terminal
    vim.keymap.set("n", "<leader>`", function()
      if jit.os == "Windows" then
        require("config.utils.terminals").run("python" .. " " .. vim.fn.expand("%"))
      else
        require("config.utils.terminals").run("time python3" .. " " .. vim.fn.expand("%"))
      end
    end, { desc = "Run Python File" })

    local dap = require("dap")
    local python_command = "python3"
    if jit.os == "Windows" then
      python_command = "python"
    end
    dap.adapters.python = {
      type = "executable",
      command = python_command,
      args = { "-m", "debugpy.adapter" },
    }
    dap.configurations.python = {
      {
        -- The first three options are required by nvim-dap
        type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
        request = "launch",
        name = "Launch file",
        justMyCode = false,
        -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

        program = "${file}", -- This configuration will launch the current file if used.
        pythonPath = function()
          -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
          -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
          -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
          local cwd = vim.fn.getcwd()
          if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
            return cwd .. "/venv/bin/python"
          elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
            return cwd .. "/.venv/bin/python"
          else
            return python_command
          end
        end,
      },
    }
  end,
})

return {}
