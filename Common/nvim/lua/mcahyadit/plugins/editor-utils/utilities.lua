return {
  { -- TODO-Comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      signs = false,
    },
  },
  { -- Find and Replace Box
    'cshuaimin/ssr.nvim',
    config = function()
      vim.keymap.set({ 'n', 'x' }, '<leader>sr', function()
        require('ssr').open()
      end)
    end,
  },
  { -- Show Color for Hex
    'catgoose/nvim-colorizer.lua',
    event = 'bufreadpre',
    lazy = false,
  },
  { -- Show LSP Progress on Bottom Right
    'j-hui/fidget.nvim',
    opts = {},
  },
  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>z', vim.cmd.UndotreeToggle)
    end,
  },
}
