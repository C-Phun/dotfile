return {
  {
    'akinsho/bufferline.nvim',
    config = function()
      require('bufferline').setup {
        options = {
          separator_style = 'slant',
          always_show_bufferline = false,
          indicator = {
            style = 'underline',
          },
          diagnostics = 'nvim_lsp',
        },
      }
      
      vim.keymap.set('n', '<S-j>', '<cmd>BufferLineCyclePrev<cr>')
      vim.keymap.set('n', '<S-k>', '<cmd>BufferLineCycleNext<cr>')
      vim.keymap.set('n', '<C-q>', '<cmd>BufferLineCloseOthers<cr>')
      vim.keymap.set('n', '<S-q>', '<cmd>BufferLinePickClose<cr>')
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'meuter/lualine-so-fancy.nvim',
    },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'horizon',
          globalstatus = true,
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'fancy_branch', 'fancy_diff' },
          -- lualine_c = { 'filename', 'buffers' },
          lualine_x = { 'encoding', 'fileformat' },
          lualine_y = { 'fancy_diagnostics' },
          lualine_z = { 'fancy_filetype', 'fancy_lsp_servers' },
        },
      }
    end,
  },
}
