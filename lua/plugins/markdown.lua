return {
  -- markdown preview
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  -- build = "cd app && yarn install",
  -- install w/o yarn or npm
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
    vim.g.mkdp_auto_close = 0 -- close preview when go to another buffer
    -- vim.g.mkdp_auto_start = 1 -- open preview when enter .md buffer
    vim.g.mkdp_open_to_the_world = 0 -- preview server available to others in network
  end,
  ft = { "markdown" },
}
