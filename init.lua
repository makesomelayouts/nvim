-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

if vim.fn.exists(":GuiFont") ~= 0 then
  vim.cmd([[GuiFont! CaskaydiaCove Nerd Font Mono:h16]])
end

-- Mute popups because of downloading Treesitter errors
vim.g.skip_ts_error = true

-- Disaable autodownloading new parsers
require("nvim-treesitter.configs").setup({
  auto_install = false,
  sync_install = false,
})
