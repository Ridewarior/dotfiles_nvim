return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = 'BufReadPost',
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "c_sharp",
      "cpp",
      "css",
      "dockerfile",
      "git_config",
      "gitignore",
      "html",
      "javascript",
      "json",
      "lua",
      "luadoc",
      "markdown",
      "query",
      "regex",
      "sql",
      "toml",
      "typescript",
      "vim",
      "vimdoc",
      "xml",
      "yaml",
    },
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    modes = {},
    ignore_install = {},
    endwise = {
      enable = true
    },
  },
  config = function(_, opts)
    -- Prefer git instead of curl to improve connectivity in some envs
    require('nvim-treesitter.install').prefer_git = true
    require('nvim-treesitter.configs').setup(opts)
  end,
}
