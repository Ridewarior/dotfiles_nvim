local M = {}

function M.configure()
  local dap = require 'dap'
  local dapui = require 'dapui'
  local widgets = require 'dap.ui.widgets'

  require('mason-nvim-dap').setup {
    -- makes bet effort to setup various debuggers
    -- with reasonable debug config
    automatic_installation = true,

    -- you can provide additonal config to the handlers,
    -- see mason-nvim-dap readme for more info
    handlers = {},
    ensure_installed = {
      'node2',
      'firefox',
      'chrome',
      'js',
    },
  }

  local map = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { desc = 'Debug: ' .. desc })
  end

  map('n', '<leader>dR', function()
    dap.run_to_cursor()
  end, 'Run to Cursor')
  map('n', '<leader>dE', function()
    dapui.eval(vim.fn.input '[Expression] > ')
  end, 'Evaluate Input')
  map('n', '<leader>dC', function()
    dap.set_breakpoint(vim.fn.input '[Condition] > ')
  end, 'Conditonal Breakpoint')
  map('n', '<leader>dU', function()
    dapui.toggle()
  end, 'Toggle UI')
  map('n', '<leader>db', function()
    dap.step_back()
  end, 'Step Back')
  map('n', '<leader>dc', function()
    dap.continue()
  end, 'Start/Continue')
  map('n', '<leader>dd', function()
    dap.disconnect()
  end, 'Disconnect')
  map('n', '<leader>de', function()
    dapui.eval()
  end, 'Evaluate')
  map('v', '<leader>de', function()
    dapui.eval()
  end, 'Evaluate')
  map('n', '<leader>dg', function()
    dap.session()
  end, 'Get Session')
  map('n', '<leader>dh', function()
    widgets.hover()
  end, 'Hover Variables')
  map('n', '<leader>dS', function()
    widgets.scopes()
  end, 'Scopes')
  map('n', '<leader>di', function()
    dap.step_into()
  end, 'Step Into')
  map('n', '<leader>do', function()
    dap.step_over()
  end, 'Step Over')
  map('n', '<leader>dp', function()
    dap.pause.toggle()
  end, 'Pause')
  map('n', '<leader>dq', function()
    dap.close()
  end, 'Quite')
  map('n', '<leader>dr', function()
    dap.repl.toggle()
  end, 'Toggle REPL')
  map('n', '<leader>dt', function()
    dap.toggle_breakpoint()
  end, 'Toggle Breakpoint')
  map('n', '<leader>dx', function()
    dap.terminate()
  end, 'Terminate')
  map('n', '<leader>du', function()
    dap.step_out()
  end, 'Step Out')

  dapui.setup {
    icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
    controls = {
      icons = {
        pause = '⏸',
        play = '▶',
        step_into = '⏎',
        step_over = '⏭',
        step_out = '⏮',
        step_back = 'b',
        run_last = '▶▶',
        terminate = '⏹',
        disconnect = '⏏',
      },
    },
  }

  -- Toggle to see last session result.
  -- This is in case the session dies due unhandled exceptions
  map('n', function()
    dapui.toggle()
  end, 'See last session results')

  dap.listeners.after.event_initialized['dapui_config'] = dapui.open()
  dap.listeners.before.event_terminated['dapui_config'] = dapui.close()
  dap.listeners.before.event_exited['dapui_config'] = dapui.close()
end

return M
