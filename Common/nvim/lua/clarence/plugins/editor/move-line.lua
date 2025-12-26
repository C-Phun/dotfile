return {
  'fedepujol/move.nvim',
  keys = {
    { '<A-j>', ':MoveLine(1)<CR>', desc = 'Move Line Up' },
    { '<A-k>', ':MoveLine(-1)<CR>', desc = 'Move Line Down' },
    { '<A-h>', ':MoveHChar(-1)<CR>', desc = 'Move Character Left' },
    { '<A-l>', ':MoveHChar(1)<CR>', desc = 'Move Character Right' },

    { '<A-j>', ':MoveBlock(1)<CR>', mode = { 'v' }, desc = 'Move Line Up' },
    { '<A-k>', ':MoveBlock(-1)<CR>', mode = { 'v' }, desc = 'Move Line Down' },
    {
      '<A-h>',
      ':MoveHBlock(-1)<CR>',
      mode = { 'v' },
      desc = 'Move Character Left',
    },
    {
      '<A-l>',
      ':MoveHBlock(1)<CR>',
      mode = { 'v' },
      desc = 'Move Character Right',
    },

    { '<A-Up>', ':MoveLine(-1)<CR>', desc = 'Move Line Up' },
    { '<A-Down>', ':MoveLine(1)<CR>', desc = 'Move Line Down' },
    { '<A-Left>', ':MoveHChar(-1)<CR>', desc = 'Move Character Left' },
    { '<A-Right>', ':MoveHChar(1)<CR>', desc = 'Move Character Right' },

    { '<A-Up>', ':MoveBlock(-1)<CR>', mode = { 'v' }, desc = 'Move Line Up' },
    { '<A-Down>', ':MoveBlock(1)<CR>', mode = { 'v' }, desc = 'Move Line Down' },
    {
      '<A-Left>',
      ':MoveHBlock(-1)<CR>',
      mode = { 'v' },
      desc = 'Move Character Left',
    },
    {
      '<A-Right>',
      ':MoveHBlock(1)<CR>',
      mode = { 'v' },
      desc = 'Move Character Right',
    },
  },
  config = function()
    require('move').setup {}
  end,
}
