return {
  'mfussenegger/nvim-dap',
  dependencies = {
    {
      'jay-babu/mason-nvim-dap.nvim',
      dependencies = {
        'mason-org/mason.nvim',
      },
      config = function()
        require('mason-nvim-dap').setup {
          automatic_installation = true,
          handlers = {
            function(config)
              require('mason-nvim-dap').default_setup(config)
            end,
          },
        }
      end,
    },
    'theHamsta/nvim-dap-virtual-text',
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    {
      'Weissle/persistent-breakpoints.nvim',
      config = function()
        require('persistent-breakpoints').setup {
          load_breakpoints_event = { 'BufReadPost' },
        }
      end,
    },
  },
  lazy = false,
  config = function()
    local dap, dapui = require 'dap', require 'dapui'

    dapui.setup()
    require('nvim-dap-virtual-text').setup()

    vim.keymap.set('n', '<leader>dt', dap.toggle_breakpoint)
    vim.keymap.set('n', '<leader>bb', dap.toggle_breakpoint)
    vim.keymap.set('n', '<leader>dg', dap.continue)
    vim.keymap.set('n', '<F5>', dap.continue)

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
  end,
}
