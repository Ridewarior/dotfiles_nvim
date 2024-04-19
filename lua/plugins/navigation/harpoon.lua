local M = {}

function M.configure()
  local harpoon = require "harpoon"
  local map = vim.keymap.set

  local function sync(evt, list)
    local file = evt.file
    local thing = vim.api.nvim_win_get_cursor(0)
    local r, c = thing[1], thing[2]

    for _, item in pairs(list.items) do
      local relative = vim.loop.cwd() .. "/" .. item.value
      if relative == file then
        item.context = {
          col = c,
          row = r,
        }
      end
    end
  end

  harpoon:setup {
    default = {
      save_on_toggle = true,
      sync_on_ui_close = true,
      BufLeave = sync,
      VimLeavePre = sync,
    },
  }

  map("n", "<leader>ha", function() harpoon:list():add() end, { desc = "[H]arpoon [A]ppend File" })
  map("n", "<leader>hs", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "[H]arpoon [S]how List" })
  map("n", "<leader>hp", function() harpoon:list():prev() end, { desc = "[H]arpoon [P]revious" })
  map("n", "<leader>hn", function() harpoon:list():next() end, { desc = "[H]arpoon [N]ext" })
  map('n', '<leader>h1', function() harpoon:list():select(1) end, { desc = '[H]arpoon File 1', silent = true })
  map('n', '<leader>h2', function() harpoon:list():select(1) end, { desc = '[H]arpoon File 2', silent = true })
  map('n', '<leader>h3', function() harpoon:list():select(3) end, { desc = '[H]arpoon File 3', silent = true })
  map('n', '<leader>h4', function() harpoon:list():select(4) end, { desc = '[H]arpoon File 4', silent = true })
  map('n', '<leader>h5', function() harpoon:list():select(5) end, { desc = '[H]arpoon File 5', silent = true })

end

return M
