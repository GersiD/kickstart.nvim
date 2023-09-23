local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", direction = "float" })
local bottom = Terminal:new({ cmd = "btop", direction = "float" })
local gdu = Terminal:new({ cmd = "gdu" })
local float_term = Terminal:new({ cmd = "zsh" })
local python_term = Terminal:new({ cmd = "bpython" })

if jit.os == "Windows" then
  float_term = Terminal:new({ cmd = "pwsh" })
  python_term = Terminal:new({ cmd = "python" })
end
local list = {
  lazygit = lazygit,
  bottom = bottom,
  gdu = gdu,
  float = float_term,
  python = python_term,
}
local close_all = function()
  for _, term in pairs(list) do
    term:close()
  end
end
return {
  lazygit = function()
    lazygit:toggle()
  end,
  bottom = function()
    bottom:toggle()
  end,
  gdu = function()
    gdu:toggle()
  end,
  float = function()
    float_term:toggle()
  end,
  python = function()
    python_term:toggle()
  end,
  close_all = close_all,
  ---@param command string
  run = function(command, opts)
    if command == nil or command == "" then
      return
    end
    require("toggleterm.terminal").Terminal
      :new({
        cmd = command,
        hidden = true,
        direction = opts and opts.direction or "float",
        close_on_exit = false,
        on_exit = function()
          -- enter normal mode
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", false, false, true), "n", false)
        end,
        float_opts = {
          border = "curved",
        },
      })
      :toggle()
  end,
}
