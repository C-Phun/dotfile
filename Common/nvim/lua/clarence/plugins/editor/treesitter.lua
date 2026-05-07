return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-context',
    },

    config = function()
      require('nvim-treesitter.configs').setup {
        sync_install = false,
        auto_install = true,
        ensure_installed = {
          'c_sharp',
        },

        indent = {
          enable = false,
        },

        highlight = {
          enable = true,
          disable = {
            'dockerfile', -- Dockerfile treesitter is damn useless
          },
        },
      }
      -- vim.treesitter.query.set(
      --   'c_sharp',
      --   'injections',
      --   [[
      --   ((comment) @injection.content
      --     (#match? @injection.content "^///")
      --     (#set! injection.language "xml"))
      --
      --   ((comment) @injection.content
      --     (#match? @injection.content "^/\\*\\*")
      --     (#set! injection.language "xml"))
      --   ]]
      -- )
    end,
  },
  {
    'itchyny/vim-cursorword',
  },
  {
    'NMAC427/guess-indent.nvim',
  },
  {
    'windwp/nvim-ts-autotag',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
  {
    'fei6409/log-highlight.nvim',
    opts = {
      minimum_len = 0,
    },
  },
}
