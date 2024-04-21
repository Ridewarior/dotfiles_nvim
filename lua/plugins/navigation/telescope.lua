local M = {}

function M.configure()
  local builtin = require 'telescope.builtin'
  local icons = require 'config.icons'
  local actions = require 'telescope.actions'
  local actions_layout = require 'telescope.actions.layout'
  local helpers = require 'plugins.util.helpers'
  local map = vim.keymap.set
  local mappings = {
    i = {
      ['<C-j>'] = actions.preview_scrolling_up,
      ['<C-k>'] = actions.preview_scrolling_down,
      ['?'] = actions_layout.toggle_preview,
    },
  }

  require('telescope').setup {
    defaults = {
      prompt_prefix = icons.ui.Telescope .. ' ',
      selection_caret = icons.ui.Forward .. ' ',
      mappings = mappings,
      border = {},
      borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      color_devicons = true,
    },
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--trim',
    },
    file_ignore_patterns = {
      'node_modules/',
      '%.git/',
      '%.DS_Stores',
      'target/',
      'build/',
      '%.o$',
    },
    color_devicons = true,
    pickers = {
      find_files = {
        hidden = true,
        find_command = { 'rg', '--files', '--hidden', '-g', '!.git' },
      },
      live_grep = {
        -- @usage don"t include the filename in the search results
        only_sort_text = true,
      },
      buffers = {
        theme = 'dropdown',
        previewer = false,
      },
    },
    extensions = {
      ['ui-select'] = {
        require('telescope.themes').get_dropdown(),
      },
      ['file_browser'] = {
        theme = 'dropdown',
        previewer = false,
        hijack_netrw = true,
        mappings = mappings,
      },
      ['project'] = {
        hidden_files = false,
        theme = 'dropdown',
      },
    },
  }

  pcall(require('telescope').load_extension, 'fzf')
  pcall(require('telescope').load_extension, 'ui-select')
  pcall(require('telescope').load_extension, 'lazygit')
  pcall(require('telescope').load_extension 'file_browser')
  pcall(require('telescope').load_extension 'project')
  pcall(require('telescope').load_extension 'projects')
  pcall(require('telescope').load_extension 'aerial')

  map('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  map('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  map('n', '<leader>sf', helpers.find_files, { desc = '[S]earch [F]iles' })
  map('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch Current [W]ord' })
  map('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  map('n', '<leader>sr', function()
    builtin.grep_string { search = vim.fn.input 'rg > ' }
  end, { desc = '[S]earch [R]ipGrep' })
  map('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files' })
  map('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
  map('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find Existing Buffers' })
  map('n', '<leader>bf', '<cmd>Telescope file_browser<cr>', { desc = '[B]rowse [F]iles ' })
  map('n', '<leader>sp', '<cmd>Telescope repo list<cr>', { desc = '[S]earch [P]rojects' })
  map('n', '<leader>ss', '<cmd>Telescope aerial<cr>', { desc = '[S]earch Document [S]ymbols' })
  map('n', '<leader>pp', function()
    require('telescope').extensions.project.project { display_tpe = 'minimal' }
  end, { desc = 'List' })

  map('n', '<leader>st', function()
    builtin.colorscheme { enable_preview = true }
  end, { desc = '[S]earch [T]hemes' })

  map('n', '<leader>sb', function()
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = '[S]earch Current [B]uffer' })

  map('n', '<leader>s/', function()
    builtin.live_grep {
      grep_open_files = true,
      prompt_title = 'Live Grep In Open Files',
    }
  end, { desc = '[S]earch [/] In Open Files' })

  map('n', '<leader>sn', function()
    builtin.find_files { cwd = vim.fn.stdpath 'config' }
  end, { desc = '[S]earch [N]eovim Files' })
end

return M
