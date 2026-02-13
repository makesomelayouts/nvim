-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

if vim.fn.exists(":GuiFont") ~= 0 then
  vim.cmd([[GuiFont! CaskaydiaCove Nerd Font Mono:h16]])
end
