return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  opts = function(_, opts)
    local actions = require("telescope.actions")

    opts.defaults = opts.defaults or {}
    opts.defaults.mappings = {
      i = { -- insert mode
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
      n = { -- normal mode
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    }

    opts.pickers = opts.pickers or {}

    opts.pickers.colorscheme = {
      enable_preview = true,
    }

    opts.pickers.find_files = {
      hidden = true,
      file_ignore_patterns = {
        ".git/",
        ".venv/",
      },
    }
  end,
}
