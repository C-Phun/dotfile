return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  dependencies = {
    {
      'folke/edgy.nvim',
      ---@module 'edgy'
      ---@param opts Edgy.Config
      opts = function(_, opts)
        for _, pos in ipairs { 'top', 'bottom', 'left', 'right' } do
          opts[pos] = opts[pos] or {}
          table.insert(opts[pos], {
            ft = 'snacks_terminal',
            size = { height = 0.4 },
            title = '%{b:snacks_terminal.id}: %{b:term_title}',
            filter = function(_buf, win)
              return vim.w[win].snacks_win
                and vim.w[win].snacks_win.position == pos
                and vim.w[win].snacks_win.relative == 'editor'
                and not vim.w[win].trouble_preview
            end,
          })
        end
      end,
    },
  },
  ---@type snacks.config
  opts = {
    dashboard = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    indent = { enabled = true },
    win = { enabled = true },
    -- terminal = {
    --   enabled = true,
    --   win = { style = 'terminal' },
    --   border = 'curved',
    -- },
  },
  -- config = function(_, opts)
  --   local snacks = require 'snacks'
  --   snacks.setup(opts)
  --   vim.keymap.set('t', '<C-q>', function()
  --     snacks.terminal.toggle()
  --   end, { desc = 'Close [t]erminal' })
  --
  --   -- vim.keymap.set('n', '<leader>t', function()
  --   --   snacks.terminal.toggle(nil, {
  --   --     name = 'float',
  --   --     win = {
  --   --       style = 'terminal',
  --   --     },
  --   --   })
  --   -- end, { desc = 'Open floating [t]erminal' })
  --   vim.keymap.set('n', '<C-t>', function()
  --     snacks.terminal.toggle(nil, {
  --       name = 'bottom',
  --       height = 15,
  --     })
  --   end, { desc = 'Open bottom [t]erminal' })
  --   vim.keymap.set('n', '<leader>lg', function()
  --     snacks.terminal.toggle('lazygit', {
  --       name = 'lazygit',
  --       border = 'curved',
  --       win = {
  --         style = 'terminal',
  --       },
  --     })
  --   end, { desc = 'Open bottom [t]erminal' })
  --   vim.keymap.set('n', '<leader>ld', function()
  --     snacks.terminal.toggle('lazydocker', {
  --       name = 'lazydocker',
  --     })
  --   end, { desc = 'Open bottom [t]erminal' })
  -- end,
}
