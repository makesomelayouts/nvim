return {
  "stevearc/aerial.nvim",
  opts = {
    -- Open sidebar by default
    open_automatic = true,
    -- Close when single
    close_automatic_events = { "unsupported", "switch_buffer" },

    -- Настройки отображения
    layout = {
      max_width = { 40, 0.2 },
      min_width = 20,
      win_opts = { winhl = "Normal:NormalFloat,FloatBorder:NormalFloat", signcolumn = "no" },
    },
    -- Автоматически открывать/закрывать
    attach_mode = "window",
    manage_folds = true,
    link_tree_to_selection = true,

    -- Настройка горячих клавиш ВНУТРИ окна Aerial
    keymaps = {
      ["k"] = "actions.prev",
      ["j"] = "actions.next",

      ["<Tab>"] = "actions.jump",
      ["<l>"] = "actions.jump",
      ["<h>"] = "actions.jump",

      ["<S-Tab>"] = "nop",

      ["q"] = "close",
      ["d"] = "close",

      ["f"] = "actions.tree_toggle",
    },
  },
  keys = {
    { "<leader>cs", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
  },
  config = function(_, opts)
    require("aerial").setup(opts)

    -- Если у тебя открыто несколько панелей (например, через edgy.nvim или разделение),
    -- стандартный способ переключения между ними (включая вкладки базы данных) — это:
    vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left pane" })
    vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right pane" })
  end,
}
