return {
  'seblyng/roslyn.nvim',
  ft = { 'cs', 'razor' },
  dependencies = {
    'neovim/nvim-lspconfig',
    {
      'tris203/rzls.nvim',
      config = true,
    },
  },
  config = function()
    require('roslyn').setup {
      cmd = cmd,
      config = {
        -- the rest of your Roslyn configuration
        handlers = require 'rzls.roslyn_handlers',
      },
    }
    local handles = {}

    vim.api.nvim_create_autocmd('User', {
      pattern = 'RoslynRestoreProgress',
      callback = function(ev)
        local token = ev.data.params[1]
        local handle = handles[token]
        if handle then
          handle:report {
            title = ev.data.params[2].state,
            message = ev.data.params[2].message,
          }
        else
          handles[token] = require('fidget.progress').handle.create {
            title = ev.data.params[2].state,
            message = ev.data.params[2].message,
            lsp_client = {
              name = 'roslyn',
            },
          }
        end
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'RoslynRestoreResult',
      callback = function(ev)
        local handle = handles[ev.data.token]
        handles[ev.data.token] = nil

        if handle then
          handle.message = ev.data.err and ev.data.err.message or 'Restore completed'
          handle:finish()
        end
      end,
    })
    vim.lsp.config("roslyn", {
      on_attach = function()
        print("This will run when the server attaches!")
      end,
      settings = {
        ["csharp|inlay_hints"] = {
          csharp_enable_inlay_hints_for_implicit_object_creation = true,
          csharp_enable_inlay_hints_for_implicit_variable_types = true,
        },
        ["csharp|code_lens"] = {
          dotnet_enable_references_code_lens = true,
        },
      },
    })
  end,
}
