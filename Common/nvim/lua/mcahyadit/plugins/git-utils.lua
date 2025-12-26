return {
  { -- Git Signs, obviously
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      current_line_blame = true,
    },
  },
  -- {
  --   'tpope/vim-fugitive'
  -- },
  -- { -- Git Client
  --   'kdheepak/lazygit.nvim',
  --   lazy = true,
  --   cmd = {
  --     'LazyGit',
  --     'LazyGitConfig',
  --     'LazyGitCurrentFile',
  --     'LazyGitFilter',
  --     'LazyGitFilterCurrentFile',
  --   },
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --   },
  --   keys = {
  --     { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
  --     { '<leader>gg', '<cmd>LazyGitCurrentFile<cr>', desc = 'LazyGit' },
  --   },
  -- },
}
