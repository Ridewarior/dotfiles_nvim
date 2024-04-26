local map = vim.keymap.set
local silent = { silent = true }

-- Get back to Netrw quickly
map('n', '<leader>pv', vim.cmd.Ex)

-- Better up/down in the case of wrapped lines
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Faster up/down
map("n", "J", "10j")
map("n", "K", "10k")

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Back to Normal mode faster
map("i", "jk", "<ESC>", silent)

-- Make splits easy
map("n", "<leader>-", "<C-W>s", { desc = "Horizontal Split", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Vertical Split", remap = true })

-- Easily move between splitHorizontals
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to bottom window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to top window" })

-- Resize windows using <ctrl> + arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Inrease Window Width" })

-- Remove highlight
map("n", "<ESC>", "<cmd>noh<cr><esc>", silent)

-- Un-do the last Un-do (re-do)
map("n", "U", "<C-R>", { desc = "Un-do last Un-do" })

-- Horizontal scrolling
map("n", "<S-ScrollWheelDown>", "<ScrollWheelRight>", silent)
map("n", "<S-ScrollWheelUp>", "<ScrollWheelLeft>", silent)
-- map("n", "<S-l>", "zL", silent)
-- map("n", "<S-h>", "zH", silent)

-- Terminal
map("t", "<ESC><ESC>", "<C-\\><C-n>", { silent = true, desc = "Enter Normal Mode" })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Move focus to left window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Move focus to right window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Move focus to bottom window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Move focus to top window" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- Buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bb", "<cmd>e #>", { desc = "Switch to Other Buffer" })

-- Keep cursor in the middle when moving by half page
map("n", "<C-d>", "<C-d>zz", silent)
map("n", "<C-u>", "<C-u>zz", silent)

-- Keep cursor in the middle moving to search results
map("n", "n", "nzzzv", silent)
map("n", "N", "Nzzzv", silent)

-- Keep your latest copy when pasting over something
map("x", "<leader>p", '"_dP', silent)

-- Search and replace word in file
map("n", "<leader>rp", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Replace Word" })

local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

-- Move between diagnostic messages
map('n', ']d', diagnostic_goto(true), { desc = 'Goto Next [D]iagnostic Message' })
map('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Goto Next [E]rror Message' })
map('n', ']w', diagnostic_goto(true, 'WARNING'), { desc = 'Goto Next [W]arning Message' })
map('n', '[d', diagnostic_goto(false), { desc = "Goto Prev [D]iagnostic Message" })
map('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Goto Prev [E]rror Message' })
map('n', '[w', diagnostic_goto(false, 'WARNING'), { desc = 'Goto Prev [W]arning Message' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- tabs
-- map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
-- map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
-- map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
-- map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
-- map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
-- map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
