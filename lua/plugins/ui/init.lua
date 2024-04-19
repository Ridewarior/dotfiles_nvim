local statusline = require 'plugins.ui.statusline'

return {
  -- Notification Manager
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
    config = function(_, opts)
      require("notify").setup(opts)
      vim.notify = require "notify"
    end,
  },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    config = statusline.configure,
  },

  -- Visual Indent lines
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },

}
