return {
  { -- Formatter
    'stevearc/conform.nvim',
    requires = {
      {
        'zapling/mason-conform.nvim',
        requires = {
          'mason-org/mason.nvim',
        },
        config = function()
          require('mason-conform').setup {
            automatic_installation = true,
          }
        end,
      },
    },
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = true,
      formatters_by_ft = {
        cpp = { 'clang-format' },
        cs = { 'csharpier' },
        nix = { 'nixfmt' },
        yaml = { 'prettierd' },
        html = { 'prettierd' },
        css = { 'prettierd' },
        xml = { 'xmlformatter' },
        zig = { 'zigfmt' },
        lua = { 'stylua' },
        python = { 'ruff' },
        jsonc = { 'prettierd' },
        json = { 'prettierd' },
        ['*'] = { 'codespell' },
      },
    },
  },
  { -- Linter
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      {
        'rshkarin/mason-nvim-lint',
        dependencies = {
          'mason-org/mason.nvim',
        },
        config = function()
          require('mason-nvim-lint').setup()
        end,
      },
    },
    config = function()
      local lint = require 'lint'
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          if vim.bo.modifiable then
            lint.try_lint()
          end
        end,
      })
    end,
  },
  -- { -- DEPRECATED: none-ls have issues when there are multiple formatters
  --   'nvimtools/none-ls.nvim',
  --   requires = { 'nvim-lua/plenary.nvim' },
  --   dependencies = {
  --     { -- syncs with mason automatically
  --       'jay-babu/mason-null-ls.nvim',
  --       requires = { 'mason-org/mason.nvim' },
  --       event = { 'BufReadPre', 'BufNewFile' },
  --       config = function()
  --         require('mason-null-ls').setup {
  --           automatic_installation = true,
  --           handlers = {},
  --           ensure_installed = {},
  --         }
  --       end,
  --     },
  --     'nvimtools/none-ls-extras.nvim',
  --   },
  --   config = function()
  --     local lsp_formatting = function(bufnr)
  --       vim.lsp.buf.format {
  --         filter = function(client)
  --           -- apply whatever logic you want (in this example, we'll only use null-ls)
  --           return client.name == 'null-ls'
  --         end,
  --         bufnr = bufnr,
  --       }
  --     end
  --
  --     -- if you want to set up formatting on save, you can use this as a callback
  --     local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
  --
  --     -- add to your shared on_attach callback
  --     local on_attach = function(client, bufnr)
  --       if client.supports_method 'textDocument/formatting' then
  --         vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
  --         vim.api.nvim_create_autocmd('BufWritePre', {
  --           group = augroup,
  --           buffer = bufnr,
  --           callback = function()
  --             lsp_formatting(bufnr)
  --           end,
  --         })
  --       end
  --     end
  --     -- vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, {})
  --     vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, {})
  --     local null_ls = require 'null-ls'
  --     null_ls.setup {
  --       sources = {
  --         null_ls.builtins.formatting.clang_format.with {
  --           filetypes = { 'c', 'cpp', 'cc', 'cs' },
  --           extra_args = { '--style=file' },
  --         },
  --       },
  --     }
  --   end,
  -- },
}
