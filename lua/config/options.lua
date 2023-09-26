-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.maplocalleader = "\\"
vim.opt.winbar = "%=%m %f %r %h%w"

vim.g.nofsync = true
vim.g.python_host_skip_check = true
vim.g.python3_host_skip_check = true
if jit.os == "Windows" then
  vim.g.python3_host_prog = "~/scoop/apps/python/current/python.exe"
  vim.g.clipboard = {
    name = "win32yank", -- set clipboard provider
    copy = {
      ["+"] = "win32yank.exe -i --crlf", -- copy to clipboard
      ["*"] = "win32yank.exe -i --crlf", -- copy to clipboard
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf", -- paste from clipboard
      ["*"] = "win32yank.exe -o --lf", -- paste from clipboard
    },
  }
else
  -- vim.g.clipboard = {
  --   name = "xclip",
  --   copy = {
  --     ["+"] = "xclip -selection clipboard",
  --     ["*"] = "xclip -selection clipboard",
  --   },
  --   paste = {
  --     ["+"] = "xclip -selection clipboard -o",
  --     ["*"] = "xclip -selection clipboard -o",
  --   },
  --   cache_enabled = true,
  -- }
  vim.g.clipboard = "unnamedplus"
end
vim.g.ruby_host_skip_check = true
vim.g.perl_host_skip_check = true
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- 1000 is the default (1 second)
vim.opt.timeoutlen = 300
-- 4000 is the default (4 seconds)
vim.opt.updatetime = 10000

vim.opt.conceallevel = 0
