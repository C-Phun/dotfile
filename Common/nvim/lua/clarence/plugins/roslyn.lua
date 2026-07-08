return {
  {
    "seblyng/roslyn.nvim",
    ft = { "cs", "razor" },
    cond = vim.fn.executable("dotnet"), -- Only if dotnet is installed
    lazy = false,
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    config = function()
      ---@module 'roslyn.config'
      ---@type RoslynNvimConfig
      local opts = {
        filewatching = "roslyn",
      }

      require("roslyn").setup()

      local handles = {}
      vim.api.nvim_create_autocmd("User", {
        pattern = "RoslynRestoreProgress",
        callback = function(ev)
          local token = ev.data.params[1]
          local handle = handles[token]
          if handle then
            handle:report({
              title = ev.data.params[2].state,
              message = ev.data.params[2].message,
            })
          else
            handles[token] = require("fidget.progress").handle.create({
              title = ev.data.params[2].state,
              message = ev.data.params[2].message,
              lsp_client = {
                name = "roslyn",
              },
            })
          end
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "RoslynRestoreResult",
        callback = function(ev)
          local handle = handles[ev.data.token]
          handles[ev.data.token] = nil

          if handle then
            handle.message = ev.data.err and ev.data.err.message or "Restore completed"
            handle:finish()
          end
        end,
      })

      local settings = {
        ["csharp|inlay_hints"] = {
          csharp_enable_inlay_hints_for_implicit_object_creation = true,
          csharp_enable_inlay_hints_for_implicit_variable_types = true,

          -- csharp_enable_inlay_hints_for_lambda_parameter_types = true,
          -- csharp_enable_inlay_hints_for_types = true,
          -- dotnet_enable_inlay_hints_for_indexer_parameters = true,
          -- dotnet_enable_inlay_hints_for_literal_parameters = true,
          -- dotnet_enable_inlay_hints_for_object_creation_parameters = true,
          -- dotnet_enable_inlay_hints_for_other_parameters = true,
          -- dotnet_enable_inlay_hints_for_parameters = true,
          -- dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = false,
          -- dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = false,
          -- dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = false,
        },
        ["csharp|formatting"] = {
          dotnet_organize_imports_on_format = true,
        },
      }

      local cmd = vim.lsp.config.roslyn.cmd

      if vim.fn.executable("nix") == 1 then
        local nixpkgs = "vscode-extension-ms-dotnettools-csharp"
        local xdg_dirs = os.getenv("XDG_DATA_DIRS")

        local nix_path
        for path in string.gmatch(xdg_dirs, "([^:]+)") do
          if path:sub(1, #"/nix/store/") == "/nix/store/" and path:find(nixpkgs, 1, true) then
            nix_path = path
            break
          end
        end

        if nix_path ~= nil and nix_path ~= "" then
          local rzls_path = vim.fs.joinpath(
            nix_path,
            "vscode",
            "extensions",
            "ms-dotnettools.csharp",
            ".razorExtension"
          )

          cmd = {
            "Microsoft.CodeAnalysis.LanguageServer",
            "--stdio",
            "--logLevel=Information",
            "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.log.get_filename()),
            -- "--razorSourceGenerator="
            --   .. vim.fs.joinpath(rzls_path, "Microsoft.CodeAnalysis.Razor.Compiler.dll"),
            -- "--razorDesignTimePath="
            --   .. vim.fs.joinpath(rzls_path, "Targets", "Microsoft.NET.Sdk.Razor.DesignTime.targets"),
            -- "--extension="
            --   .. vim.fs.joinpath(rzls_path, "Microsoft.VisualStudioCode.RazorExtension.dll"),
          }
        end
      end
      vim.lsp.config("roslyn", {
        cmd = cmd,
        settings = settings,
      })
      vim.lsp.config("html", {
        filetypes = vim.list_extend(vim.lsp.config.html.filetypes, { "razor" }),
      })

      -- Tree Sitter and
      vim.filetype.add({
        extension = {
          razor = "razor", -- Why?? lmao
          cshtml = "razor",
        },
      })
      vim.treesitter.query.set(
        "c_sharp",
        "injections",
        [[
        ((comment) @injection.content
          (#match? @injection.content "^///")
          (#set! injection.language "xml"))

        ((comment) @injection.content
          (#match? @injection.content "^/\\*\\*")
          (#set! injection.language "xml"))
        ]]
      )
    end,
  },
}
