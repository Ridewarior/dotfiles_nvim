require 'config.options'
require 'config.lazy'

vim.api.nvim_create_autocmd('user', {
  group = vim.api.nvim_create_augroup('myconfig', { clear = true }),
  pattern = 'VeryLazy',
  callback = function()
    require 'config.keymaps'
    require 'config.autocmds'
  end,
})
