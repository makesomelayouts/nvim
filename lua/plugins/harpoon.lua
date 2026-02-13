return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    local map = vim.keymap.set

    -- Add current file to Harpoon + <leader>H
    map("n", "<leader>a", function()
      harpoon:list():add()
    end, { desc = "Harpoon Add File" })

    -- Show Harpoon file list
    map("n", "<leader>h", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Harpoon Menu" })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "harpoon",
      callback = function()
        -- Open selected file in file list
        map("n", "<Tab>", function()
          harpoon.ui:select_menu_item()
        end, { buffer = true, remap = true })
        map("n", "h", function()
          harpoon.ui:select_menu_item()
        end, { buffer = true, remap = true })
        map("n", "l", function()
          harpoon.ui:select_menu_item()
        end, { buffer = true, remap = true })
        map("n", "<leader>", function()
          harpoon.ui:select_menu_item()
        end, { buffer = true, remap = true })

        map("n", "d", function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end)

        -- Disable Shift+Tab in file list
        map("n", "<S-Tab>", "<nop>", { buffer = true })
      end,
    })
  end,
}
