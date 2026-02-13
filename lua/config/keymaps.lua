-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- completion by: C-j, C-k, Tab, Enter
-- terminal toggle (C-t)

-- free to use:
-- <leader>e

-- FIXME:
-- remove all unused keymaps

-- TODO:
-- restore somehow last deleted buffer
-- wrap whole word/sentence into "" or '' by shortcut in visual mode
-- select session (spaceqS)
-- tag stack? (C-t)
-- space e - free to use

local map = vim.keymap.set

map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })

map("n", "<C-w>", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })

-- quit neovim  FIXME:
map("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit All" })

-- open explorer
map("n", "<C-n>", function()
  Snacks.explorer.open()
end, { desc = "Toggle Explorer" })

-- open markdown preview
map("n", "<leader>m", "<cmd>MarkdownPreview<cr>", { desc = "Markdown preview" })

-- Todo list
map("n", "<leader>t", function()
  Snacks.picker.todo_comments()
end, { desc = "TODO List" })
map("n", "<leader>T", function()
  Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
end, { desc = "TODO,FIX,FIXME List" })

-- move lines in visual mode
map("v", "<Tab>", ">", { desc = "Toggle comments" })
map("v", "<S-Tab>", "<", { desc = "Toggle comments" })

-- space f = fold todo: maybe better way
map("n", "<leader>f", "za", { desc = "toggle fold" })

-- open terminal
map("n", "<c-t>", function()
  Snacks.terminal(nil, { cwd = LazyVim.root() })
end, { desc = "Toggle terminal" })
-- hide terminal
map("t", "<C-t>", "<cmd>close<cr>", { desc = "Hide Terminal" })

-- Более умное дублирование с перемещением (сохраняет курсор)
map("n", "<A-S-j>", ":t.<CR>", { desc = "Duplicate line down (keep cursor)" })
map("n", "<A-S-k>", ":t-1<CR>", { desc = "Duplicate line up (keep cursor)" })

-- Для визуального режима с перемещением после дублирования:
map("v", "<A-S-j>", ":'<,'>t'><CR>gv", { desc = "Duplicate selection down (keep selection)" })
map("v", "<A-S-k>", ":'<,'>t'<-1<CR>gv", { desc = "Duplicate selection up (keep selection)" })

-- rename
map({ "n", "x" }, "<leader>r", function()
  LazyVim.format({ force = true })
end, { desc = "Format" })

-- Choose colorscheme with preview
map("n", "<leader>uC", "<cmd>Telescope colorscheme<cr>", { desc = "Colorschemes" })

-- Choose project
map("n", "<leader>p", function()
  Snacks.picker.projects()
end, { desc = "Projects" })

-- Find files
map("n", "<leader><leader>", LazyVim.pick("files", { hidden = true }), { desc = "Find files" })

-- Перемещение буферов влево/вправо через Alt + h/l / Ctrl + h/l
map("n", "<C-H>", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer left" })
map("n", "<C-L>", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer right" })
map("n", "<A-h>", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer left" })
map("n", "<A-l>", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer right" })

-- Настройки для Markdown (Ctrl+k)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    local opts = { buffer = true, silent = true }

    -- Режим вставки (оставляем как есть)
    map("i", "<C-k>", "[]()<Left><Left><Left>", opts)

    -- Normal: берем слово и оборачиваем программно
    map("n", "<C-k>", function()
      local word = vim.fn.expand("<cword>")
      local col = vim.api.nvim_win_get_cursor(0)[2]
      local line = vim.api.nvim_get_current_line()

      -- Находим границы слова, чтобы заменить именно его
      local start_col = vim.fn.matchstrpos(line:sub(1, col + word:len()), [[\k*$]])[2]
      local end_col = start_col + word:len()

      local new_line = line:sub(1, start_col) .. "[" .. word .. "]()" .. line:sub(end_col + 1)
      vim.api.nvim_set_current_line(new_line)
      vim.api.nvim_win_set_cursor(0, { vim.api.nvim_win_get_cursor(0)[1], start_col + word:len() + 2 })
    end, opts)

    -- Visual: берет выделение (даже V) и чистит его
    map("v", "<C-k>", function()
      -- Копируем выделение в регистр z, чтобы не портить системный
      vim.cmd('normal! "zy')
      local text = vim.fn.getreg("z"):gsub("[\n\r]", "") -- Удаляем переносы строк
      local result = "[" .. text .. "]()"
      -- Вставляем результат на место выделения
      vim.cmd('normal! gv"zc' .. result)
      -- Ставим курсор в круглые скобки
      vim.cmd("normal! hi")
    end, opts)
  end,
})
