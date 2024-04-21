local map = vim.keymap.set
local silent = { silent = true }
local helpers = require 'plugins.util.helpers'

-- Get back to Netrw quickly
-- map('n', '<leader>pv', vim.cmd.Ex)

-- Faster up/down
map("n", "J", "10j")
map("n", "K", "10k")

-- Back to Normal mode faster
map("i", "jk", "<ESC>", silent)

-- Easily move between splits
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to bottom window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to top window" })

-- Remove highlight
map("n", "<ESC>", vim.cmd.nohlsearch, silent)

-- Redo the last Undo
map("n", "U", "<C-R>", silent)

-- Horizontal scrolling
map("n", "<S-ScrollWheelDown>", "<ScrollWheelRight>", silent)
map("n", "<S-ScrollWheelUp>", "<ScrollWheelLeft>", silent)
map("n", "<S-l>", "zL", silent)
map("n", "<S-h>", "zH", silent)

-- Exit Terminal mode
map("t", "<ESC><ESC>", "<C-\\><C-n>", { silent = true, desc = "Exit Term Mode" })

-- Move selected chunk up/down
map("v", "J", ":m '>+1<CR>gv=gv", silent)
map("v", "K", ":m '<-2<CR>gv=gv", silent)

-- Keep cursor in the middle when moving by half page
map("n", "<C-d>", "<C-d>zz", silent)
map("n", "<C-u>", "<C-u>zz", silent)

-- Keep search term in middle
map("n", "n", "nzzzv", silent)
map("n", "N", "Nzzzv", silent)

-- Keep your latest copy when pasting over something
map("x", "<leader>p", '"_dP', silent)

-- Search and replace word in file
map("n", "<leader>rp", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Replace Word" })

-- Move between diagnostic messages
map('n', ']d', helpers.diagnostics_find(true), { desc = 'Goto Next [D]iagnostic Message' })
map('n', ']e', helpers.diagnostics_find(true, 'ERROR'), { desc = 'Goto Next [E]rror Message' })
map('n', ']w', helpers.diagnostics_find(true, 'WARNING'), { desc = 'Goto Next [W]arning Message' })
map('n', '[d', helpers.diagnostics_find(false), { desc = "Goto Prev [D]iagnostic Message" })
map('n', '[e', helpers.diagnostics_find(false, 'ERROR'), { desc = 'Goto Prev [E]rror Message' })
map('n', '[w', helpers.diagnostics_find(false, 'WARNING'), { desc = 'Goto Prev [W]arning Message' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
