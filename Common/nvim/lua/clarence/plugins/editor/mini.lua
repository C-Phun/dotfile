return {
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- - sa)  - [S]urround with [)]pattern
    -- - sr'" - [R]eplace [S]urround from ['] to ["]pattern
    require('mini.surround').setup()

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    -- local statusline = require 'mini.statusline'
    -- set use_icons to true if you have a Nerd Font
    -- statusline.setup { use_icons = vim.g.have_nerd_font }

    require('mini.visits').setup()
    require('mini.pairs').setup()
    require('mini.cursorword').setup()
    require('mini.map').setup {
      -- Highlight integrations (none by default)
      integrations = nil,

      -- Symbols used to display data
      symbols = {
        -- Encode symbols. See `:h MiniMap.config` for specification and
        -- `:h MiniMap.gen_encode_symbols` for pre-built ones.
        -- Default: solid blocks with 3x2 resolution.
        encode = nil,

        -- Scrollbar parts for view and line. Use empty string to disable any.
        scroll_line = '▶',
        scroll_view = '╎',
      },

      -- Window options
      window = {
        -- Whether window is focusable in normal way (with `wincmd` or mouse)
        focusable = false,

        -- Side to stick ('left' or 'right')
        side = 'right',

        -- Whether to show count of multiple integration highlights
        show_integration_count = true,

        -- Total width
        width = 10,

        -- Value of 'winblend' option
        winblend = 25,

        -- Z-index
        zindex = 10,
      },
    }
    MiniMap.toggle()
    vim.keymap.set('n', '<Leader>mt', MiniMap.toggle)
    vim.keymap.set('n', '<Leader>mr', MiniMap.refresh)
    -- require('mini.animate').setup()

    --------------
    -- MiniIcons
    --------------
    require('mini.icons').setup {
      directory = {
        ['.git'] = { glyph = '' },
        ['.vscode'] = { glyph = '' },
      },
      file = {
        ['docker-compose.yml'] = { glyph = '󰡨' },
        ['.clangd'] = { glyph = '' },
        ['.clang-format'] = { glyph = '' },
        ['.clang-tidy'] = { glyph = '' },
        ['.pre-commit-config.yaml'] = { glyph = '󰛢' },
      },
      filetype = {
        razor = { glyph = '', hl = 'MiniIconsYellow' },
        make = { glyph = '' },
        cmake = { glyph = '' },
        cmakecache = { glyph = '' },
        dosbatch = { glyph = '' },
        sh = { glyph = '' },
        fish = { glyph = '󰈺' },
        zsh = { glyph = '󱨃' },
        nu = { glyph = '󰟆' },

        c = { glyph = '' },
        cpp = { glyph = '' },
      },
      extension = {
        h = { glyph = '' },
        hpp = { glyph = '', hl = 'MiniIconsPurple' },
      },
    }
    MiniIcons.mock_nvim_web_devicons()
    MiniIcons.tweak_lsp_kind()
  end,
  --------------
}
