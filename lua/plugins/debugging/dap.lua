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

  dapui.setup {}
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
end

return M
