return {
  -- {
  --   'christoomey/vim-tmux-navigator',
  --   lazy = false,
  --   cmd = {
  --     'TmuxNavigateLeft',
  --     'TmuxNavigateDown',
  --     'TmuxNavigateUp',
  --     'TmuxNavigateRight',
  --     'TmuxNavigatePrevious',
  --     'TmuxNavigatorProcessList',
  --   },
  --   keys = {
  --     { '<C-h>', '<cmd><C-B>TmuxNavigateLeft<cr>' },
  --     { '<C-j>', '<cmd><C-B>TmuxNavigateDown<cr>' },
  --     { '<C-k>', '<cmd><C-B>TmuxNavigateUp<cr>' },
  --     { '<C-l>', '<cmd><C-B>TmuxNavigateRight<cr>' },
  --
  --     { '<C-Left>', '<cmd>TmuxNavigateLeft<cr>' },
  --     { '<C-Down>', '<cmd>TmuxNavigateDown<cr>' },
  --     { '<C-Up>', '<cmd>TmuxNavigateUp<cr>' },
  --     { '<C-Right>', '<cmd>TmuxNavigateRight<cr>' },
  --
  --     { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
  --   },
  -- },
  {
    'mrjones2014/smart-splits.nvim',
    lazy = false,
    config = function()
      vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
      vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
      vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
      vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)

      vim.keymap.set('n', '<C-Left>', require('smart-splits').move_cursor_left)
      vim.keymap.set('n', '<C-Down>', require('smart-splits').move_cursor_down)
      vim.keymap.set('n', '<C-Up>', require('smart-splits').move_cursor_up)
      vim.keymap.set('n', '<C-Right>', require('smart-splits').move_cursor_right)
    end,
  },
  {
    'nvim-zh/colorful-winsep.nvim',
    config = true,
    event = { 'WinLeave' },
  },
}
