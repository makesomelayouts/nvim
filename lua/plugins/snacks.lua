return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = {
            hidden = true,
            exclude = { "node_modules", ".git" },
            include = { ".env" },
          },
          explorer = {
            layout = { preset = "default", preview = true },
            jump = { close = true },
          },
        },
        win = {
          input = {
            keys = {
              ["<C-l>"] = { "focus_preview", mode = { "i", "n" } },
              ["<C-h>"] = { "nop", mode = { "i", "n" } },
            },
          },
          preview = {
            keys = {
              ["<C-h>"] = { "focus_input", mode = { "i", "n" } },
              ["<C-l>"] = { "nop", mode = { "i", "n" } },
            },
          },
        },
      },
    },
  },
}
