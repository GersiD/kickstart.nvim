-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set('n', '<A-j>', '15j', {})
vim.keymap.set('n', '<A-k>', '15k', {})
-- vim.keymap.set("n", "<cr>", "ciw", { remap = true, desc = "Change word" })
vim.keymap.set('n', '<TAB>', '<cmd>BufferLineCycleNext<cr>', { desc = 'Prev buffer' })
vim.keymap.set('n', '<S-TAB>', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<cr>', { desc = 'Neotree' })
vim.keymap.set('n', 'U', '<cmd>redo<cr>', { desc = 'Redo' })
vim.keymap.set('n', '<C-f>', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
    layout_config = {
      width = function(_, max_columns, _)
        return math.min(max_columns, 100)
      end,

      height = function(_, _, max_lines)
        return math.min(max_lines, 20)
      end,
    },
    winblend = 10,
    previewer = false,
    skip_empty_lines = true,
  }))
end, { desc = 'Find in buffer' })
vim.keymap.set('n', '<leader>gg', function()
  require('config.utils.terminals').lazygit()
end, { desc = 'LazyGit' })
vim.keymap.set('n', '<leader>tb', function()
  require('config.utils.terminals').bottom()
end, { desc = 'Float Btm' })
vim.keymap.set('n', '<leader>td', function()
  require('config.utils.terminals').gdu()
end, { desc = 'Float Disk Usage' })
vim.keymap.set('n', '<leader>tf', function()
  require('config.utils.terminals').float()
end, { desc = 'Float' })
vim.keymap.set('n', '<leader>tp', function()
  require('config.utils.terminals').python()
end, { desc = 'Python' })

vim.api.nvim_set_keymap('v', '<leader>/', 'gc', { desc = 'Comment Selection' })
vim.api.nvim_set_keymap('n', '<leader>/', 'Vgc', { desc = 'Comment Line' })
vim.keymap.set('n', 'q', '<C-w>q', { desc = 'Quit', remap = true })
vim.api.nvim_set_keymap('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Quit' })
vim.keymap.set('t', '<C-q>', function()
  require('config.utils.terminals').close_all()
end, { desc = 'Close Open Terminals' })

-- Package manager keymaps
vim.keymap.set('n', '<leader>ps', '<cmd>Lazy<cr>', { desc = 'Package Status' })
vim.keymap.set('n', '<leader>pS', '<cmd>Lazy sync<cr>', { desc = 'Package Sync' })

-- LSP keymaps
vim.keymap.set('n', '<leader>la', function()
  local curr_row = vim.api.nvim_win_get_cursor(0)[1]
  vim.lsp.buf.code_action({
    ['range'] = {
      ['start'] = { curr_row, 0 },
      ['end'] = { curr_row, 100 },
    },
  })
end, { desc = 'Code Action on Line' })
vim.keymap.set('n', '<leader>ll', vim.lsp.codelens.run, { desc = 'LSP CodeLens' })
vim.keymap.set('n', '<leader>lL', vim.lsp.codelens.refresh, { desc = 'Refresh CodeLens' })
vim.keymap.set('n', '<leader>li', '<cmd>LspInfo<cr>', { desc = 'LSP Info' })
vim.keymap.set('n', '<leader>lS', '<cmd>LspStart<cr>', { desc = 'LSP Start' })
vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, { desc = 'LSP Diag' })
-- vim.keymap.set("n", "<leader>lf", require("lazyvim.plugins.lsp.format").format, { desc = "LSP Format" })
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { desc = 'LSP Rename' })
vim.keymap.set('n', '<leader>`', function()
  vim.ui.input({ prompt = 'Run Command: ' }, function(cmd)
    require('config.utils.terminals').run(cmd)
  end)
end, { desc = 'Run Command' })
vim.keymap.set('n', 'gt', function()
  -- I want <CR> to open the selection in a vertical split
  require('telescope.builtin').lsp_type_definitions(require('telescope.themes').get_cursor({
    jump_type = 'vsplit',
    reuse_win = true,
    initial_mode = 'normal',
    attach_mappings = function(_, map)
      map('n', '<CR>', require('telescope.actions').select_vertical)
      return true
    end,
  }))
end, { desc = 'LSP Type Definitions' })
vim.keymap.set('n', 'gd', function()
  require('telescope.builtin').lsp_definitions(require('telescope.themes').get_cursor({
    jump_type = 'vsplit',
    reuse_win = true,
    initial_mode = 'normal',
    attach_mappings = function(_, map)
      map('n', '<CR>', require('telescope.actions').select_vertical)
      return true
    end,
  }))
end, { desc = 'LSP Definitions' })
vim.keymap.set('n', 'gs', function()
  require('telescope.builtin').lsp_definitions(require('telescope.themes').get_cursor({
    jump_type = 'vsplit',
    reuse_win = false,
    initial_mode = 'normal',
    attach_mappings = function(_, map)
      map('n', '<CR>', require('telescope.actions').select_vertical)
      return true
    end,
  }))
end, { desc = 'LSP Definitions Split' })
vim.keymap.set('n', '<leader>fs', function()
  require('telescope.builtin').treesitter()
end, { desc = 'Find Symbols' })
vim.keymap.set('n', 'gi', function()
  require('telescope.builtin').lsp_implementations(
    require('telescope.themes').get_cursor({ jump_type = 'vsplit', reuse_win = true })
  )
end, { desc = 'LSP Implementations' })
vim.keymap.set('n', '<leader>uf', '<CMD>KickstartFormatToggle<CR>', { desc = 'Format Toggle' })

-- DAP Keymaps
vim.keymap.set('n', '<F7>', function()
  require('dap').step_out()
end, { desc = 'DAP Step Out' })
vim.keymap.set('n', '<F8>', function()
  require('dap').continue()
end, { desc = 'DAP Continue' })
vim.keymap.set('n', '<F9>', function()
  require('dap').step_into()
end, { desc = 'DAP Step Into' })
vim.keymap.set('n', '<F10>', function()
  require('dap').step_over()
end, { desc = 'DAP Step Over' })
vim.keymap.set('n', 'K', function()
  local dap_open = require('dap').session() ~= nil
  if dap_open then
    require('dapui').eval()
  else
    vim.lsp.buf.hover()
  end
end, { desc = 'DAP Eval' })

-- Git Keymaps
vim.keymap.set('n', '<leader>gd', function()
  local view = require('diffview.lib').get_current_view()
  if view then
    -- Current tabpage is a Diffview; close it
    vim.cmd(':DiffviewClose')
  else
    -- No open Diffview exists: open a new one
    vim.cmd(':DiffviewOpen')
  end
end, { desc = 'Diffview' })

-- Buffer keymaps
-- Delete all buffers except current
vim.keymap.set('n', '<leader>bD', function()
  vim.notify('Deleting all buffers except current', 'info', { timeout = 500 })
  local current = vim.api.nvim_get_current_buf()
  for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
    if buffer ~= current then
      vim.api.nvim_buf_delete(buffer, {})
    end
  end
end, { desc = 'Delete all buf except current' })
vim.keymap.set('n', '<C-s>', function()
  local cur_buf_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':~:.')
  vim.notify('  ' .. cur_buf_name, 'info', { timeout = 500 })
  vim.cmd(':w')
end, { desc = 'Save' })
-- Fuzzy search all open buffers
vim.keymap.set('n', '<leader>bf', function()
  require('telescope.builtin').buffers({
    ignore_current_buffer = true,
    sort_mru = true,
    attach_mappings = function(_, map)
      map('n', 'dd', function(prompt_bufnr)
        require('telescope.actions').delete_buffer(prompt_bufnr)
      end)
      return true
    end,
  })
end, { desc = 'Find Buffer' })

-- Window Keymaps
-- Move to window using the <ctrl> hjkl keys
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to left window', remap = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window', remap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window', remap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to right window', remap = true })
