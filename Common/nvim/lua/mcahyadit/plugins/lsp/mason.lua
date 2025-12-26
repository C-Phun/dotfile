return {
  -- Lsp Installer
  'mason-org/mason.nvim',
  opts = {
    ui = {
      icons = {
        package_installed = '✓',
        package_pending = '➜',
        package_uninstalled = '✗',
      },
    },
  },
  config = function()
    require('mason').setup {
      registries = {
        'github:mason-org/mason-registry',
        -- Can put additonal LSP here
        'github:Crashdummyy/mason-registry', -- roslyn
      },
    }
  end,
}
