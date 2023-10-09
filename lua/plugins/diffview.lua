return {
  'sindrets/diffview.nvim',
  cmd = 'DiffviewOpen',
  opts = function()
    local custom_keymaps = {
      { 'n', 'q', '<cmd>DiffviewClose<CR>', { desc = 'Close Diffview' } },
      {
        'n',
        '<leader>gs',
        function()
          require('diffview.actions').toggle_stage_entry()
        end,
        { desc = 'Toggle Stage file' },
      },
      {
        'n',
        '<leader>gS',
        function()
          require('diffview.actions').stage_all()
        end,
        { desc = 'Stage all' },
      },
      {
        'n',
        '<leader>gU',
        function()
          require('diffview.actions').unstage_all()
        end,
        { desc = 'Unstage all' },
      },
      {
        'n',
        '<leader>gc',
        function()
          local commit_message = vim.fn.input({ prompt = 'Commit message: ', default = nil })
          if commit_message then
            local command = string.format('!git commit -m "%s"', commit_message)
            vim.cmd(command)
          end
        end,
        { desc = 'Commit' },
      },
      {
        'n',
        '<leader>gP',
        function()
          vim.cmd('!git push')
        end,
        { desc = 'Push' },
      },
    }
    return {
      enhanced_diff_hl = true,
      view = {
        default = {
          layout = 'diff2_vertical',
          winbar_info = true,
        },
        merge_tool = {
          layout = 'diff3_mixed',
        },
      },
      keymaps = {
        view = custom_keymaps,
        file_panel = custom_keymaps,
      },
    }
  end,
}
