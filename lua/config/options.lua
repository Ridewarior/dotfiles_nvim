local opt = vim.opt

-- Globals
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.markdown_recommended_style = 0 -- Fix markdown indent setting

opt.completeopt = 'menu,menuone,noselect' -- Insert mode completions (see `:h completeopt`)
opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
opt.formatoptions = 'jcqlnt' -- List of options for vim's default formatting (see `h: fo-table` for these options)
opt.grepformat = '%f:%l:%c:%m' -- Pattern for RipGrep
opt.grepprg = 'rg --vimgrep' -- Use Ripgrep for grep
opt.tabstop = 2 -- Number of spaces tabs input
opt.shiftwidth = 2 -- Size of an indent (basically just using tabs here)
opt.shiftround = true -- Round indent
opt.shortmess:append({ W = true, I = true, c = true, C = true }) -- Avoids certain prompts (see `:h shortmess`)
opt.softtabstop = 2 -- see `:h softtabstop`
opt.breakindent = true -- Wrapped lines will continue the same indent level
opt.autoindent = true -- Copy indent from current line when starting a new line
opt.smartindent = true -- Insert indents automatically
opt.number = true -- Print line number
opt.relativenumber = true -- Relative line numbers
opt.mouse = "a" -- Enable mouse mode
opt.showmode = false -- Toggles mode display (off since we have Lualine installed)
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.undofile = true -- See `:h undofile`
opt.expandtab = true -- use spaces instead of tabs
opt.ignorecase = true -- Ignore casing when searching using `/`
opt.smartcase = true -- Don't ignore case when using more than 2 capitals
opt.signcolumn = "yes" -- Always show the signcolumn (The gutter on the left side)
opt.updatetime = 250 -- How many milliseconds until the swap file is written to disk
opt.timeoutlen = 300 -- Milliseconds to wait for keymaps (lowered to trigger which-key faster)
opt.splitright = true -- Put new vertical splits to the right
opt.splitbelow = true -- Put new horizontal splits below
opt.splitkeep = 'screen' -- Determines scroll behavior when opening/closing/resizing horizontal splits
opt.list = true -- Show some invisible characters (tabs, spaces, etc)
--listchars = { tab = "» ", trail = "·", nbsp = "␣", eol = "󱞣" },
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" } -- Custom symbols for invisible characters (only when `opt.list = true`)
opt.inccommand = "split" -- Preview incremental substitutions
opt.cursorline = true -- highlight the current line
opt.scrolloff = 8 -- Always have at least x amount of lines above/below cursor visible
opt.sidescrolloff = 8 -- Always have a list x amount of spaces left/right cursor visible
opt.hlsearch = true -- Highlights search patterns
opt.wrap = false -- Disable line wrap
opt.termguicolors = true -- True color support
opt.confirm = true -- Confi4rm to save changes before exiting modified buffers
opt.pumwidth = 10 -- Popup width
opt.pumheight = 10 -- Max number of entries in a popup
opt.pumblend = 10 -- Popup blend
opt.wildmode = "longest:full,full" -- Command-line completion modes
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.virtualedit = 'block' -- Allows cursor to move where there is no text in visual block mode
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true }) -- clear any mappings to <space>
