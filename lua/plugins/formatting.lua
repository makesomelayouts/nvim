return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
      },

      format_on_save = function(bufnr)
        if vim.bo[bufnr].filetype == "html" then
          return false
        end

        return {
          timeout_ms = 500,
          lsp_format = "fallback",
        }
      end,
    },
  },
}
