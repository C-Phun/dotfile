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
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_cursor = 'green'
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_enable_bold = true
      -- vim.g.gruvbox_material_dim_inactive_windows = 1
      vim.g.gruvbox_material_visual = 'green background'
      vim.g.gruvbox_material_diagnostic_text_highlight = 1
      vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
      vim.g.gruvbox_material_transparent_backgroud = 2

      vim.cmd.colorscheme 'gruvbox-material'
    end,
  },
}
