return {
  'neovim/nvim-lspconfig',
  dependencies = {
    {
      'mason-org/mason-lspconfig.nvim',
      dependencies = {
        'mason-org/mason.nvim',
      },
      config = function()
        require('mason-lspconfig').setup {
          automatic_enable = true,
          -- ensure_installed = {
          --   'clang-format',
          --   'clangd',
          --   'codelldb',
          --   'csharpier',
          --   'html',
          --   'jsonlint',
          --   'lua_ls',
          --   'prettierd',
          --   'roslyn',
          --   'stylua',
          --   'vale',
          --   'xmlformatter',
          -- },
        }
      end,
    },
    {
      'antosha417/nvim-lsp-file-operations',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-neo-tree/neo-tree.nvim', -- makes sure that this loads after Neo-tree.
      },
      config = function()
        require('lsp-file-operations').setup()
      end,
    },
    {
      'Fildo7525/pretty_hover',
      event = 'LspAttach',
      opts = {},
    },
    'saghen/blink.cmp',
    {
      'romus204/referencer.nvim',
      config = function()
        require('referencer').setup {
          enable = true,
        }
      end,
    },
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if
          client
          and client:supports_method(
            vim.lsp.protocol.Methods.textDocument_documentHighlight,
            event.buf
          )
        then
          local highlight_augroup =
            vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds {
                group = 'kickstart-lsp-highlight',
                buffer = event2.buf,
              }
            end,
          })
        end
      end,
    })
    vim.diagnostic.config {
      severity_sort = true,
      float = { border = 'rounded', source = 'if_many' },
      underline = { severity = vim.diagnostic.severity.ERROR },
      signs = vim.g.have_nerd_font and {
        text = {
          [vim.diagnostic.severity.ERROR] = '󰅚 ',
          [vim.diagnostic.severity.WARN] = '󰀪 ',
          [vim.diagnostic.severity.INFO] = '󰋽 ',
          [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
      } or {},
      virtual_text = {
        source = 'if_many',
        spacing = 2,
        format = function(diagnostic)
          local diagnostic_message = {
            [vim.diagnostic.severity.ERROR] = diagnostic.message,
            -- [vim.diagnostic.severity.WARN] = diagnostic.message,
            -- [vim.diagnostic.severity.INFO] = diagnostic.message,
            -- [vim.diagnostic.severity.HINT] = diagnostic.message,
          }
          return diagnostic_message[diagnostic.severity]
        end,
      },
    }
    vim.lsp.inlay_hint.enable(true)

    --================
    -- KeyBinds
    --================
    -- vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover)
    vim.keymap.set('n', '<leader>k', require('pretty_hover').hover)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.references, {})
    vim.keymap.set('n', 'gD', Snacks.picker.lsp_references)
    vim.keymap.set('n', '<leader>.', vim.lsp.buf.code_action)
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename)
  end,
}
