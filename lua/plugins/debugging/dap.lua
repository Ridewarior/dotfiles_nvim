local M = {}

function M.configure()
  local dap = require 'dap'
  local dapui = require 'dapui'
  local widgets = require 'dap.ui.widgets'

  local function get_csharp_debugger()
    -- local home = os.getenv 'HOME'
    -- local debugger_loc = home .. '/.local/share/nvim/netcoredbg'
    -- return debugger_loc
    local mason_registry = require 'mason-registry'
    local debugger = mason_registry.get_package 'netcoredbg'
    return debugger:get_install_path() .. '/netcoredbg'
  end

  local function get_js_debugger()
    local path = vim.fn.stdpath 'data'
    return path .. '/lazy/vscode-js-debug'
  end

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

  dap.listeners.after.event_initialized['dapui_config'] = dapui.open()
  dap.listeners.before.event_terminated['dapui_config'] = dapui.close()
  dap.listeners.before.event_exited['dapui_config'] = dapui.close()

  dap.configurations.cs = {
    {
      type = 'coreclr',
      name = 'launch - netcoredbg',
      request = 'launch',
      program = function()
        return vim.fn.input('Path to dll > ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
      end,
    },
  }
  dap.adapters.coreclr = {
    type = 'executable',
    command = get_csharp_debugger(),
    args = { '--interpreter=vscode' },
  }
  dap.adapters.netcoredbg = {
    type = 'executable',
    command = get_csharp_debugger(),
    args = { '--interpreter=vscode' },
  }

  require('dap-vscode-js').setup {
    node_path = 'node',
    debugger_path = get_js_debugger(),
    adapters = {
      'pwa-node',
      'pwa-chrome',
      'pwa-msedge',
      'node-terminal',
      'pwa-extensionHost',
    },
  }

  for _, language in ipairs { 'typescript', 'javascript' } do
    require('dap').configurations[language] = {
      {
        type = 'pwa-node',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
        cwd = '${workspaceFolder}',
      },
      {
        type = 'pwa-node',
        request = 'attach',
        name = 'Attach',
        processId = require('dap.utils').pick_process,
        cwd = '${workspaceFolder}',
      },
      {
        type = 'pwa-node',
        request = 'launch',
        name = 'Debug Jest Tests',
        -- trace = true, -- include debugger info
        runtimeExecutable = 'node',
        runtimeArgs = {
          './node_modules/jest/bin/jest.js',
          '--runInBand',
        },
        rootPath = '${workspaceFolder}',
        cwd = '${workspaceFolder}',
        console = 'integratedTerminal',
        internalConsoleOptions = 'neverOpen',
      },
      {
        type = 'pwa-chrome',
        name = 'Attach - Remote Debugging',
        request = 'attach',
        program = '${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        port = 9222, -- Start Chrome google-chrome --remote-debugging-port=9222
        webRoot = '${workspaceFolder}',
      },
      {
        type = 'pwa-chrome',
        name = 'Launch Chrome',
        request = 'launch',
        url = 'http://localhost:5173', -- This is for Vite. Change it to the framework you use
        webRoot = '${workspaceFolder}',
        userDataDir = '${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir',
      },
    }
  end

  for _, language in ipairs { 'typescriptreact', 'javascriptreact' } do
    require('dap').configurations[language] = {
      {
        type = 'pwa-chrome',
        name = 'Attach - Remote Debugging',
        request = 'attach',
        program = '${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        port = 9222, -- Start Chrome google-chrome --remote-debugging-port=9222
        webRoot = '${workspaceFolder}',
      },
      {
        type = 'pwa-chrome',
        name = 'Launch Chrome',
        request = 'launch',
        url = 'http://localhost:5173', -- This is for Vite. Change it to the framework you use
        webRoot = '${workspaceFolder}',
        userDataDir = '${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir',
      },
    }
  end
end

return M
