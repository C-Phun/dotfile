return {
  {
    --   'github/copilot.vim'
  },
  { -- Autocompletion
    'saghen/blink.cmp',
    version = '1.*',
    cond = not vim.g.vscode,
    event = 'VimEnter',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
        opts = {},
      },
      {
        -- LSP for NeoVim config
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          },
        },
      },
      {
        'xzbdmw/colorful-menu.nvim',
        config = function()
          require('colorful-menu').setup()
        end,
      },
    },
    opts = {
      keymap = {
        preset = 'enter',
        ['<Esc>'] = {
          function(cmp)
            cmp.cancel()
            vim.cmd 'stopinsert'
          end,
        },
      },

      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },

        menu = {
          draw = {
            columns = { { 'kind_icon' }, { 'label', gap = 1 } },
            components = {
              label = {
                text = function(ctx)
                  return require('colorful-menu').blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require('colorful-menu').blink_components_highlight(ctx)
                end,
              },
            },
          },
        },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },
      snippets = { preset = 'luasnip' },
      -- fuzzy = { implementation = 'prefer_rust_with_warning' },
      fuzzy = { implementation = 'lua' },
      signature = { enabled = true },
    },
  },
}
