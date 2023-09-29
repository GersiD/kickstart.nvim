-- Add any additional options here
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.loader.enable()
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.o.termguicolors = true
vim.opt.winbar = '%=%m %f %r %h%w'

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Set completeopt to have a better completion experience
-- vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
vim.g.nofsync = true
vim.g.python_host_skip_check = true
vim.g.python3_host_skip_check = true
if jit.os == 'Windows' then
  vim.g.python3_host_prog = '~/scoop/apps/python/current/python.exe'
  vim.g.clipboard = {
    name = 'win32yank', -- set clipboard provider
    copy = {
      ['+'] = 'win32yank.exe -i --crlf', -- copy to clipboard
      ['*'] = 'win32yank.exe -i --crlf', -- copy to clipboard
    },
    paste = {
      ['+'] = 'win32yank.exe -o --lf', -- paste from clipboard
      ['*'] = 'win32yank.exe -o --lf', -- paste from clipboard
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
  vim.g.clipboard = 'unnamedplus'
end
vim.g.ruby_host_skip_check = true
vim.g.perl_host_skip_check = true
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

vim.opt.conceallevel = 0
-- This file is automatically loaded by plugins.core
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

local opt = vim.opt

opt.autowrite = true -- Enable auto write
opt.clipboard = 'unnamedplus' -- Sync with system clipboard
opt.completeopt = 'menu,menuone,noselect'
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = 'jcroqlnt' -- tcqj
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --vimgrep'
opt.ignorecase = true -- Ignore case
opt.inccommand = 'nosplit' -- preview incremental substitute
opt.laststatus = 0
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = 'a' -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize' }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true })
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { 'en' }
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.wildmode = 'longest:full,full' -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap

if vim.fn.has('nvim-0.9.0') == 1 then
  opt.splitkeep = 'screen'
  opt.shortmess:append({ C = true })
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
