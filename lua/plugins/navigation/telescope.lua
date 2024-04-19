local M = {}

function M.configure()
  local builtin = require "telescope.builtin"
  local map = vim.keymap.set

  require("telescope").setup {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim",
    },
    file_ignore_patterns = {
      "node_modules/",
      "%.git/",
      "%.DS_Stores",
      "target/",
      "build/",
      "%.o$",
    },
    color_devicons = true,
    pickers = {
      find_files = { hidden = true },
      live_grep = {
        -- @usage don"t include the filename in the search results
        only_sort_text = true,
      },
    },
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown(),
      },
    },
  }

  pcall(require("telescope").load_extension, "fzf")
  pcall(require("telescope").load_extension, "ui-select")
  pcall(require("telescope").load_extension, "lazygit")

  map("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
  map("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
  map("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
  map("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
  map("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch Current [W]ord" })
  map("n", "<leader>sg", builtin.git_files, { desc = "[S]earch [G]it Files" })
  map("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
  map("v", "<leader>srw", builtin.grep_string, { desc = "[S]earch [R]ipGrep For [W]ord" })
  map("n", "<leader>sr", function()
    builtin.grep_string { search = vim.fn.input "rg > " }
  end, { desc = "[S]earch [R]ipGrep" })
  map("n", "<leader>s.", builtin.oldfiles, { desc = "[S]earch Recent Files ('.' for repeat)" })
  map("n", "<leader>sc", builtin.commands, { desc = "[S]earch [C]ommands" })
  map("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find Existing Buffers" })

  map("n", "<leader>st", function()
    builtin.colorscheme(require("telescope.themes").get_dropdown {
      winblend = 10,
      previewer = true,
    })
  end, { desc = "[S]earch [T]hemes" })

  map("n", "<leader>/", function()
    builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = "[/] Fuzzy Search In Current Buffer" })

  map("n", "<leader>s/", function()
    builtin.live_grep {
      grep_open_files = true,
      prompt_title = "Live Grep In Open Files",
    }
  end, { desc = "[S]earch [/] In Open Files" })

  map("n", "<leader>sn", function()
    builtin.find_files { cwd = vim.fn.stdpath "config" }
  end, { desc = "[S]earch [N]eovim Files" })
end

return M
