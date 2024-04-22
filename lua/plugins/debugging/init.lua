local dap = require 'plugins.debugging.dap'
return {
  {
    'mfussenegger/nvim-dap',
    event = 'BufReadPre',
    dependencies = {
      -- Creates debugger UI
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-telescope/telescope-dap.nvim',

      -- Installs debug adapters for you
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',

      -- Allows you to debug any lua code nvim is currently using
      'jbyuki/one-small-step-for-vimkind',
    },
    config = dap.configure,
  },
}
