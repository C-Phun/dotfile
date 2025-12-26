return { -- Terminals
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup()
    local Terminal = require('toggleterm.terminal').Terminal
    vim.keymap.set('t', '<C-q>', '<CMD>ToggleTerm<CR>')

    -- Floating Terminal
    local float = Terminal:new {
      direction = 'float',
      float_opts = {
        border = 'curved',
      },
    }
    function _float_toggle()
      float:toggle()
    end

    vim.keymap.set('n', '<leader>t', '<CMD>lua _float_toggle()<CR>')

    -- Bottom Terminal
    local bottom = Terminal:new {
      direction = 'horizontal',
      winbar = {
        enabled = false,
      },
    }
    function _bottom_toggle()
      bottom:toggle()
    end

    vim.keymap.set('n', '<C-t>', '<CMD>lua _bottom_toggle()<CR>')

    -- LazyGit Terminal
    local lazygit = Terminal:new {
      direction = 'float',
      float_opts = {
        border = 'curved',
      },
      cmd = 'lazygit',
    }
    function _lazygit_toggle()
      lazygit:toggle()
    end

    vim.keymap.set('n', '<leader>lg', '<CMD>lua _lazygit_toggle()<CR>')

    -- JJUI Terminal
    local jjui = Terminal:new {
      direction = 'float',
      float_opts = {
        border = 'curved',
      },
      cmd = 'jjui',
    }
    function _jjui_toggle()
      jjui:toggle()
    end

    vim.keymap.set('n', '<leader>jj', '<CMD>lua _jjui_toggle()<CR>')

    -- LazyDocker Terminal
    local lazydocker = Terminal:new {
      direction = 'float',
      float_opts = {
        border = 'curved',
      },
      cmd = 'lazydocker',
    }
    function _lazydocker_toggle()
      lazydocker:toggle()
    end

    vim.keymap.set('n', '<leader>ld', '<CMD>lua _lazydocker_toggle()<CR>')
  end,
}
