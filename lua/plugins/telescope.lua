return {
  "nvim-telescope/telescope.nvim",
  -- Принудительно регистрируем команду во вселенной Neovim
  cmd = "Telescope",
  -- Корректно сливаем ваши настройки со стандартными настройками LazyVim
  opts = function(_, opts)
    opts.pickers = opts.pickers or {}

    -- Включаем предпросмотр тем оформления
    opts.pickers.colorscheme = {
      enable_preview = true,
    }

    -- Ваши правила для поиска файлов
    opts.pickers.find_files = {
      hidden = true, -- показывать скрытые файлы
      file_ignore_patterns = {
        ".git/",
        ".venv/",
        ".env",
      },
    }
  end,
}
