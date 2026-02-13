local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    {
      "LazyVim/LazyVim",
      import = "lazyvim.plugins",
      picker = {
        files = {
          hidden = true,
        },
      },
    },

    -- to make folder plugins work
    { import = "plugins" },

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

    -- markdown preview
    {
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
    },

    -- todo-comments
    {
      -- TODO:,
      -- PERF:,
      -- HACK:,
      -- NOTE:,
      -- FIX:,
      -- WARNING:
      "folke/todo-comments.nvim",
    },

    -- comments
    {
      "numToStr/Comment.nvim",
      dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
      event = { "BufReadPost", "BufNewFile" },
      config = function()
        require("Comment").setup({
          pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        })
        -- кастомные маппинги
        local keymap = vim.keymap

        -- <leader>c для комментирования в normal режиме
        keymap.set("n", "<leader>c", function()
          require("Comment.api").toggle.linewise.current()
        end, { desc = "Toggle comment line" })

        -- <leader>c для комментирования в visual режиме
        keymap.set(
          "v",
          "<leader>c",
          "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
          { desc = "Toggle comment selection" }
        )
      end,
    },

    -- fix notify - "no information available" when using some languages in one file
    {
      "folke/noice.nvim",
      opts = {
        function(_, opts)
          table.insert(opts.routes, {
            filter = {
              event = "notify",
              find = "No information available",
            },
            opts = { skip = true },
          })
        end,

        lsp = {
          hover = {
            -- Set not show a message if hover is not available
            -- ex: shift+k on Typescript code
            silent = true,
          },
        },
      },
    },

    -- telescope
    {
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
    },

    -- override nvim-cmp and add cmp-emoji
    {
      "hrsh7th/nvim-cmp",
      dependencies = { "hrsh7th/cmp-emoji" },
      ---@param opts cmp.ConfigSchema
      opts = function(_, opts)
        table.insert(opts.sources, { name = "emoji" })
      end,
    },

    -- completion
    {
      "saghen/blink.cmp",
      opts = {
        keymap = {
          preset = "default",
          ["<C-j>"] = { "select_next", "fallback" },
          ["<C-k>"] = { "select_prev", "fallback" },
          ["<Tab>"] = { "accept", "fallback" },
          ["<CR>"] = { "accept", "fallback" },
        },
      },
    },

    -- better fold
    {
      "kevinhwang91/nvim-ufo",
      dependencies = "kevinhwang91/promise-async",
      config = function()
        -- Настройки для корректной работы ufo
        vim.o.foldcolumn = "1" -- показывает узкую колонку слева с индикаторами
        vim.o.foldlevel = 99 -- открывает всё по умолчанию (UFO управляет этим сам)
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        -- Используем Treesitter как основной источник для фолдов
        require("ufo").setup({
          provider_selector = function(bufnr, filetype, buftype)
            return { "treesitter", "indent" }
          end,
        })

        -- Ваши кеймапы
        vim.keymap.set("n", "zR", require("ufo").openAllFolds)
        vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
        vim.keymap.set("n", "<leader>f", "za", { desc = "Toggle Fold" })
      end,
    },

    -- discord
    {
      "vyfor/cord.nvim",
    },

    -- hide node_modules
    {
      "folke/snacks.nvim",
      opts = {
        picker = {
          sources = {
            files = {
              hidden = true,
              exclude = { "node_modules", ".git" },
              include = { ".env" },
            },
          },
        },
      },
    },

    -- Настройка подсветки цветов (mini.hipatterns)
    {
      "brenoprata10/nvim-highlight-colors",
      event = "VeryLazy",
      opts = {
        enable_tailwind = true,
        enable_named_colors = true,
        enable_short_hex = true,
      },
      config = function(_, opts)
        require("nvim-highlight-colors").setup(opts)
      end,
    },

    -- let blink pick lua by default
    {
      "saghen/blink.cmp",
      opts = {
        fuzzy = { implementation = "lua" },
      },
    },

    -- make explorer being float
    {
      "folke/snacks.nvim",
      opts = {
        picker = {
          sources = {
            explorer = {
              -- Use "default" or "vertical" to make it float
              layout = { preset = "default", preview = true },
              -- Recommended: close the float after selecting a file
              jump = { close = true },
            },
          },
        },
      },
    },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },

  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
