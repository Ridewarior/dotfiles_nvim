return {
  -- Keymaps for commenting
  {
    'numToStr/Comment.nvim',
    lazy = false,
    config = true,
  },

  -- Comment features
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    opts = { signs = false },
  },

  -- Undo Tree
  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = '[U]ndoTree' })
    end,
  },

  -- Auto 'shiftwidth' and 'expandwidth'
  { 'tpope/vim-sleuth' },
}
