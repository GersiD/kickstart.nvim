return {
  "stevearc/oil.nvim",
  opts = {
    -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
    -- Set to false if you still want to use netrw.
    -- default_file_explorer = true,
    -- Id is automatically added at the beginning, and name at the end
    -- See :help oil-columns
    columns = {
      "icon",
      -- "permissions",
      "size",
      -- "mtime",
    },
    -- Set to `false` to remove a keymap
    -- See :help oil-actions for a list of all available actions
    keymaps = {
      ["?"] = "actions.show_help",
      ["q"] = "actions.close",
      ["<CR>"] = "actions.select",
      ["<C-s>"] = false,
      ["v"] = "actions.select_vsplit",
      ["h"] = "actions.select_split",
      -- ["p"] = "actions.preview", -- cant use p because we need that
      ["<C-j>"] = "actions.preview_scroll_down",
      ["<C-k>"] = "actions.preview_scroll_up",
      ["r"] = "actions.refresh",
      ["b"] = "actions.parent",
      -- ["y"] = "actions.copy_entry_path", -- cant use y because we need that
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = "actions.tcd",
      ["gs"] = "actions.change_sort",
      ["H"] = "actions.toggle_hidden",
    },
  },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>o", "<cmd>Oil<cr>", { desc = "Oil", noremap = true, silent = true } },
  },
}
