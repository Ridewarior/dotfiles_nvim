return {
  -- Allows you to set different themes per file type
  {
    'folke/styler.nvim',
    event = 'VeryLazy',
    config = function()
      require('styler').setup {
        themes = {
          markdown = { colorscheme = 'gruvbox' },
          help = { colorscheme = 'gruvbox' },
        },
      }
    end,
  },

  -- Themes
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      local tokyonight = require 'tokyonight'
      tokyonight.setup {
        style = 'night',
        -- uncomment these to make the theme transparent
        -- transparent = true,
        -- styles = {
        --   sidebars = 'transparent',
        --   floats = 'transparent',
        -- },
      }
      tokyonight.load()
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("gruvbox").setup()
    end,
  },
  { "EdenEast/nightfox.nvim" },
  { "Mofiqul/vscode.nvim" },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      variant = "auto",
      dark_variant = "main",
      dim_inactive_windows = false,
      styles = {
        transparency = true,
      },
    },
    config = function(_, opts)
      local rosepine = require "rose-pine"
      rosepine.setup(opts)
    end,
  },
}
