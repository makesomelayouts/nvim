return {
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        "emmet_language_server",
        "cssls",
        "html",
        "tailwindcss",
        "vtsls",
        "dockerls",
        "docker_compose_language_service",
        "eslint",
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
      },
    },
  },
}
