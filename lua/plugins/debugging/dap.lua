local M = {}

function M.configure()
  local dap = require "dap"
  local dapui = require "dapui"

  require("mason-nvim-dap").setup {
    -- makes bet effort to setup various debuggers
    -- with reasonable debug config
    automatic_installation = true,

    -- you can provide additonal config to the handlers,
    -- see mason-nvim-dap readme for more info
    handlers = {},
    ensure_installed = {
      "node2",
      "firefox",
      "chrome",
      "js",
    },
  }

  local map = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { desc = "Debug: " .. desc })
  end

  map("<F5>", dap.continue, "Start/Continue")
  map("<F11>", dap.step_into, "Step Into")
  map("<F10>", dap.step_over, "Step Over")
  map("<S-F11>", dap.step_out, "Step Out")
  map("<leader>b", dap.toggle_breakpoint, "Toggle Breakpoint")
  map("<leader>B", function()
    dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
  end, "Set Breakpoint")

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
  map('<F7>', dapui.toggle, 'See last session result.')

  dap.listeners.after.event_initialized["dapui_config"] = dapui.open()
  dap.listeners.before.event_terminated["dapui_config"] = dapui.close()
  dap.listeners.before.event_exited["dapui_config"] = dapui.close()
end

return M
