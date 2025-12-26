return {
  '2kabhishek/nerdy.nvim',
  lazy = false,
  dependencies = {
    'folke/snacks.nvim',
  },
  cmd = 'Nerdy',
  opts = {
    max_recents = 30, -- Configure recent icons limit
    add_default_keybindings = false, -- Add default keybindings
    copy_to_clipboard = false, -- Copy glyph to clipboard instead of inserting
  },
  config = function()
    require('nerdy').setup()
    vim.keymap.set('n', '<leader>nf', '<cmd>Nerdy<cr>')
  end,
}
