return {
  -- Keymaps for commenting
  {
    'numToStr/Comment.nvim',
    lazy = false,
    config = true,
  },

  -- Comment features
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    opts = { signs = false },
  },

  -- Undo Tree
  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = '[U]ndoTree' })
    end,
  },

  -- Auto 'shiftwidth' and 'expandwidth'
  { 'tpope/vim-sleuth' },

  -- Mini plugins that bring lots of good stuff :)
  -- Better text objects
  {
    'echasnovski/mini.ai',
    version = false,
    keys = {
      { 'a', mode = { 'x', 'o' } },
      { 'i', mode = { 'x', 'o' } },
    },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      init = function()
        -- no need to load the plugin, since we only use the queries from it
        require('lazy.core.loader').disable_rtp_plugin 'nvim-treesitter-textobjects'
      end,
    },
    otps = function()
      local ai = require 'mini.ai'
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { '@block.outer', '@conditional.outer', '@loop.outer' },
            i = { '@block.inner', '@conditional.inner', '@loop.inner' },
          }, {}),
          f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
          c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }, {})
        },
      }
    end,
    config = function(_, opts)
      local ai = require 'mini.ai'
      ai.setup(opts)
    end,
  },

  -- Allows you to easily remove buffers
  {
    'echasnovski/mini.bufremove',
    keys = {
      { '<leader>bd', function() require('mini.bufremove').delete(0, false) end, desc = 'Delete Buffer' },
      { '<leader>bD', function() require('mini.bufremove').delete(0, true) end,  desc = 'Delete Buffer (Force)' },
    }
  },

  -- Surround Actions
  {
    'echasnovski/mini.surround',
    version = false,
    opts = {},
  },

  -- Tabs
  {
    'echasnovski/mini.tabline',
    version = false,
    opts = {},
  }
}
