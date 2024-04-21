local telescope = require 'plugins/navigation/telescope'
local harpoon = require 'plugins/navigation/harpoon'
local nvimtree = require 'plugins/navigation/nvimtree'

return {
  -- Fuzzy Finder
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable "make" == 1
        end,
      },
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "nvim-telescope/telescope-file-browser.nvim" },
      { "nvim-telescope/telescope-project.nvim" },
      {
        "ahmedkhalf/project.nvim",
        config = function()
          require('project_nvim').setup {
            detection_methods = { 'pattern', 'lsp' },
            patterns = { '.git' },
            ignore_lsp = { 'null-ls' },
          }
        end,
      },
      { "cljoly/telescope-repo.nvim" },
      {
        "stevearc/aerial.nvim",
        config = true,
      }
    },
    config = telescope.configure,
  },

  -- Navigation Shortcuts
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    config = harpoon.configure,
  },

  -- File tree
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    config = nvimtree.configure,
  },
}
