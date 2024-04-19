local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

--  INFO: There are two things to remember for plugin configs
--  Full info can be found on the lazy.nvim repo: https://github.com/folke/lazy.nvim
--  1. `opts` is a table that will be passed into `Plugin.config(_, opts)`
--    It's common for plugins to ask for default/plugin configs to be passed in here
--  2. `config` is the function executed when the plugin loads.
--    To use the default implementation without `opts`, set `config` to `true`

require('lazy').setup {
  spec = {
    { import = 'plugins' },
    { import = 'plugins.extras.ui' },
  },
  install = {
    colorscheme = { 'tokyonight' }
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        --"matchit",
        --"matchparen",
        --"netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  ui = {
    icons = {
      cmd = " ",
      config = "",
      event = " ",
      ft = " ",
      init = " ",
      import = " ",
      keys = " ",
      lazy = "󰒲 ",
      loaded = "●",
      not_loaded = "○",
      plugin = " ",
      runtime = " ",
      require = "󰢱 ",
      source = " ",
      start = " ",
      task = "✔ ",
      list = {
        "●",
        "➜",
        "★",
        "‒",
      },
    },
  },
}

vim.keymap.set('n', '<leader>z', vim.cmd.Lazy, { desc = 'Plugin Manager' })
