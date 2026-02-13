-- telescope
return {
  "nvim-telescope/telescope.nvim",
  opts = {
    pickers = {
      colorscheme = {
        enable_preview = true,
      },
      find_files = {
        file_ignore_patterns = {
          ".git",
          ".venv",
          ".env",
          -- "node_modules",
        },

        -- Set hidden to true to include hidden files (optional)
        hidden = true,
      },
    },
  },
}
