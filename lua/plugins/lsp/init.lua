local mason = require 'plugins/lsp/mason'
local autos = require 'plugins/lsp/autos'

return {
  {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    dependencies = {
      -- Auto install lsps/related tools to stdpath
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- Status updates for lsps
      { 'j-hui/fidget.nvim',        config = true, },

      -- Configures Lua LSP for Neovim config
      -- runtime and plugins used for completion,
      -- annotations, and signatures of Neovim apis
      { "folke/neodev.nvim",        config = true, },

      -- Visual feedback for lsp renaming
      { "smjonas/inc-rename.nvim",  config = true },

      -- Show signatures as you type
      { "ray-x/lsp_signature.nvim", config = true, },

      -- null-ls
      {
        "jose-elias-alvarez/null-ls.nvim",
        event = "BufReadPre",
        dependencies = { "mason.nvim" },
      },
    },
    config = mason.configure,
  },

  -- Auto Complete
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-cmdline" },
      { "hrsh7th/cmp-nvim-lua" },
      { "saadparwaiz1/cmp_luasnip" },
      {
        -- Build step required for regex support in snippets.
        -- Most Windows envs don't support this
        -- Remove the condition below to re-enable for Windows
        "L3MON4D3/LuaSnip",
        build = (function()
          if vim.fn.has "win32" == 1 or vim.fn.executable "make" == 0 then
            return
          end
          return "make install_jsregexp"
        end)(),
        dependencies = {
          "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
          end,
        },
        opts = {
          history = true,
          delete_check_events = "TextChanged",
        },
        keys = {
          {
            "<tab>",
            function()
              return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
            end,
            expr = true,
            remap = true,
            silent = true,
            mode = "i",
          },
          {
            "<tab>",
            function()
              require("luasnip").jump(1)
            end,
            mode = "s",
          },
          {
            "<s-tab>",
            function()
              require("luasnip").jump(-1)
            end,
            mode = { "i", "s" },
          },
        },
      },
    },
    config = autos.configure_completions,
  },

  -- Auto Format
  {
    'stevearc/conform.nvim',
    config = autos.configure_formatting,
  },

  -- Auto-Close for paired symbols
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = autos.configure_autopairs,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = true,
  },
  {
    "RRethy/nvim-treesitter-endwise",
    event = "InsertEnter",
  },
}
