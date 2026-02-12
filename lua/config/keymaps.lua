-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

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

-- completion by: C-j, C-k, Tab, Enter
-- terminal toggle (C-t)

-- Choose colorscheme with preview
map("n", "<leader>uC", "<cmd>Telescope colorscheme<cr>", { desc = "Colorschemes" })

-- Choose project
map("n", "<leader>p", function()
  Snacks.picker.projects()
end, { desc = "Projects" })

-- Find files
map("n", "<leader><leader>", LazyVim.pick("files", { hidden = true }), { desc = "Find files" })

-- FIXME:
-- remove all unused keymaps

-- TODO:
-- restore somehow last deleted buffer
-- wrap whole word/sentence into "" or '' by shortcut in visual mode
-- select session (spaceqS)
-- tag stack? (C-t)
-- space e - free to use
