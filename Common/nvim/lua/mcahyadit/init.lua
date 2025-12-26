kTermux = os.getenv 'TERMUX_VERSION'

require 'mcahyadit.set'
require 'mcahyadit.keybinds'
require 'mcahyadit.lazy'
require 'mcahyadit.filetypes'
require 'mcahyadit.shells'

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
