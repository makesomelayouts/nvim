return {
  -- Настройка подсветки цветов (mini.hipatterns)
  {
    "brenoprata10/nvim-highlight-colors",
    event = "VeryLazy",
    opts = {
      enable_tailwind = true,
      enable_named_colors = true,
      enable_short_hex = true,
    },
    config = function(_, opts)
      require("nvim-highlight-colors").setup(opts)
    end,
  },
}
