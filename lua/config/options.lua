local opt = vim.opt

-- Globals
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.breakindent = true
opt.autoindent = true
opt.smartindent = true
opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.showmode = false
opt.clipboard = "unnamedplus"
opt.undofile = true
opt.fileencoding = "utf-8"
opt.expandtab = true
opt.title = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = "yes"
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.list = true
--listchars = { tab = "» ", trail = "·", nbsp = "␣", eol = "󱞣" },
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.inccommand = "split"
opt.cursorline = true
opt.scrolloff = 10
opt.sidescrolloff = 8
opt.hlsearch = true
opt.wrap = false
opt.termguicolors = true
-- opt.cmdheight = 0
opt.confirm = true
opt.pumwidth = 10
opt.pumblend = 10
opt.wildmode = "longest:full,full"
