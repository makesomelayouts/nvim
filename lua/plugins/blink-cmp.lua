return {
  -- completion
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "default",
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<Tab>"] = { "accept", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
    },
    fuzzy = { implementation = "lua" },
  },
}
