return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = 'VeryLazy',
  cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
  opts = {
    highlight = { enable = true },
    auto_install = true,
    sync_install = false,
    indent = { enable = true },
    endwise = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = 'gnn',
        node_incremental = 'grn',
        scope_incremental = 'grc',
        node_decremental = 'grm',
      },
    },
    matchup = {
      enable = true,
    },
    ensure_installed = {
      'bash',
      'c',
      'diff',
      'dockerfile',
      'git_config',
      'gitignore',
      'html',
      'javascript',
      'jsdoc',
      'jsonc',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'regex',
      'toml',
      'vim',
      'vimdoc',
      'xml',
      'yaml',
    },
  },
  dependencies = {
    { 'RRethy/nvim-treesitter-endwise' },
  },
  config = function(_, opts)
    if type(opts.ensure_installed) == "table" then
      --@type table<string, boolean>
      local added = {}
      opts.ensure_installed = vim.tbl_filter(function(lang)
        if added[lang] then
          return false
        end
        added[lang] = true
        return true
      end, opts.ensure_installed)
    end
    -- Prefer git instead of curl to improve connectivity in some cases
    require('nvim-treesitter.install').prefer_git = true
    require('nvim-treesitter.configs').setup(opts)
  end,
}
