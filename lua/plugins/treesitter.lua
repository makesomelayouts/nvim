return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      auto_install = false,
      ensure_installed = {
        -- basic for neovim
        "lua",
        "vim",
        "vimdoc",
        "query",

        -- web dev
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",
        "tsx", -- react (tsx/jsx)

        -- frameworks
        "vue",
        "svelte",

        -- cfgs & styles
        "json",
        "jsonc", -- json with comments (tsconfig.json)
        "yaml",
        "toml",
        "markdown",
        "markdown_inline",
      },
    },
  },
}
