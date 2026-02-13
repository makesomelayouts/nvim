return {
  -- comments
  {
    "numToStr/Comment.nvim",
    dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
      -- кастомные маппинги
      local keymap = vim.keymap

      -- <leader>c для комментирования в normal режиме
      keymap.set("n", "<leader>c", function()
        require("Comment.api").toggle.linewise.current()
      end, { desc = "Toggle comment line" })

      -- <leader>c для комментирования в visual режиме
      keymap.set(
        "v",
        "<leader>c",
        "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
        { desc = "Toggle comment selection" }
      )
    end,
  },

  -- todo-comments
  {
    -- TODO:,
    -- PERF:,
    -- HACK:,
    -- NOTE:,
    -- FIX:,
    -- WARNING:
    "folke/todo-comments.nvim",
  },
}
