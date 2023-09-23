local types = require("luasnip.util.types")
return {
  "L3MON4D3/LuaSnip",
  opts = {
    history = true,
    delete_check_events = "TextChanged",
    ext_opts = {
      [types.insertNode] = {
        unvisited = {
          virt_text = { { "|", "Conceal" } },
          virt_text_pos = "inline",
        },
      },
      -- This is needed because LuaSnip differentiates between $0 and other
      -- placeholders (exitNode and insertNode). So this will highlight the last
      -- jump node.
      [types.exitNode] = {
        unvisited = {
          virt_text = { { "|", "Conceal" } },
          virt_text_pos = "inline",
        },
      },
    },
  },
}
