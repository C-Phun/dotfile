return {
  'stevearc/overseer.nvim',
  config = function()
    require('overseer').setup()
    vim.keymap.set('n', '<leader><S-b>', '<CMD>OverseerRun<CR>', {
      desc = 'Call OverseerRun',
    })
  end,
}
