return {
  -- {
  --   -- help visual-multi
  --   'mg979/vim-visual-multi',
  --   init = function ()
  --     vim.g.VM_maps = {
  --       ['Add Cursor Up'] = '<C-A-Up>',
  --       ['Add Cursor Down'] = '<C-A-Down>',
  --
  --       ['Motion Down'] = '<Down>',
  --       ['Motion Up'] = '<Up>',
  --       ['Motion Left'] = '<Left>',
  --       ['Motion Right'] = '<Right>',
  --     }
  --
  --   end
  -- },
  {
    'brenton-leighton/multiple-cursors.nvim',
    cond = not vim.g.vscode,
    version = '*', -- Use the latest tagged version
    opts = {
      pre_hook = function()
        vim.g.minipairs_disable = true
      end,
      post_hook = function()
        vim.g.minipairs_disable = false
      end,
    },            -- This causes the plugin setup function to be called
    lazy = false, -- Cannot work if false
    keys = {
      {
        '<S-A-j>',
        '<Cmd>MultipleCursorsAddDown<CR>',
        mode = { 'n', 'x' },
        desc = 'Add cursor and move down',
      },
      {
        '<S-A-k>',
        '<Cmd>MultipleCursorsAddUp<CR>',
        mode = { 'n', 'x' },
        desc = 'Add cursor and move up',
      },

      {
        '<S-A-Up>',
        '<Cmd>MultipleCursorsAddUp<CR>',
        mode = { 'n', 'x' },
        desc = 'Add cursor and move up',
      },
      {
        '<S-A-Down>',
        '<Cmd>MultipleCursorsAddDown<CR>',
        mode = { 'n', 'x' },
        desc = 'Add cursor and move down',
      },
    },
  },
}
