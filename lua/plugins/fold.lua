return {
  -- better fold
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    config = function()
      -- Настройки для корректной работы ufo
      vim.o.foldcolumn = "1" -- показывает узкую колонку слева с индикаторами
      vim.o.foldlevel = 99 -- открывает всё по умолчанию (UFO управляет этим сам)
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Используем Treesitter как основной источник для фолдов
      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
      })

      -- Ваши кеймапы
      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
      vim.keymap.set("n", "<leader>f", "za", { desc = "Toggle Fold" })
    end,
  },
}
