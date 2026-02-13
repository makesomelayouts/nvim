return {
  -- hide node_modules
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

          -- make explorer float
          explorer = {
            -- Use "default" or "vertical" to make it float
            layout = { preset = "default", preview = true },
            -- Recommended: close the float after selecting a file
            jump = { close = true },
          },
        },
      },
    },
  },
}
