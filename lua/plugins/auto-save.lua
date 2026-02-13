return {
  -- auto-save
  {
    "pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup({
        trigger_events = { "BufLeave", "WinLeave", "FocusLost" },

        condition = function(buf)
          local fn = vim.fn
          local utils = require("auto-save.utils.data")

          local ignore_ft = { "NvimTree", "TelescopePrompt", "help", "lazy", "mason", "alpha", "dashboard" }
          local ignore_buftype = { "nofile", "terminal", "prompt", "quickfix", "nofile" }

          local ft = fn.getbufvar(buf, "&filetype")
          local bt = fn.getbufvar(buf, "&buftype")
          local modifiable = fn.getbufvar(buf, "&modifiable")
          local readonly = fn.getbufvar(buf, "&readonly")

          -- Пропускаем специальные буферы
          if utils.not_in(ft, ignore_ft) and utils.not_in(bt, ignore_buftype) then
            if modifiable == 1 and readonly == 0 then
              return true
            end
          end

          return false
        end,

        execution_message = {
          message = "",
          dim = 0,
          cleaning_interval = 0,
        },

        debounce_delay = 300, -- Увеличил задержку
        enabled = true,
      })

      vim.keymap.set("n", "<leader>as", ":ASToggle<CR>", { desc = "Toggle auto-save" })
      vim.cmd("ASToggle")
      vim.cmd("ASToggle")
    end,
  },
}
