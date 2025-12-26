return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = false },
    dashboard = { enabled = true },
    explorer = { enabled = false },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    picker = {
      enabled = true,
      sources = {
        explorer = {
          auto_close = true,
          hidden = true,
          ignore = true,
          git_status = false,
          layout = {
            auto_hide = { 'input' },
          },
        },
      },
      formatters = {
        file = {
          filename_first = true,
        },
      },
      layout = {
        preset = 'telescope',
      },
    },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {
      notification = {
        -- wo = { wrap = true } -- Wrap notifications
      },
    },
  },
  keys = {
    {
      '<leader>/',
      function()
        Snacks.picker.lines()
      end,
    },
    {
      '<leader>sp',
      function()
        Snacks.picker.files {
          hidden = true,
          follow = true,
          exclude = {"*.meta"},
          confirm = function(_, item)
            moveToFront(vim.fn.bufnr(item.file, true))
          end,
        }
      end,
    },
    {
      '<leader>sf',
      function()
        Snacks.picker.grep {
          confirm = function(picker, item)
            moveToFront(vim.fn.bufnr(item.file, true))
            vim.api.nvim_win_set_cursor(0, item.pos)
          end,
        }
      end,
    },
    {
      '<leader><S-p>',
      function()
        Snacks.picker.files {
          cwd = vim.fn.stdpath 'config',
          confirm = function(_, item)
            local path = vim.fn.stdpath 'config' .. '/' .. item.file
            if vim.env.MSYSTEM ~= nil then
              local cygpath = vim.system({ 'cygpath', '-w', path }):wait()
              path = cygpath.stdout:gsub('[\r\n]+$', '')
            end
            print(path)
            moveToFront(vim.fn.bufnr(path, true))
          end,
        }
      end,
    },
    {
      '<leader>sh',
      function()
        Snacks.picker.help()
      end,
    },
    -- {
    --   '<leader>e',
    --   function()
    --     Snacks.explorer()
    --   end,
    -- },
    {
      '<leader>sC',
      function()
        Snacks.picker.commands()
      end,
      desc = 'Commands',
    },
    {
      '<leader>sk',
      function()
        Snacks.picker.keymaps()
      end,
      desc = 'Keymaps',
    },
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end

        -- Override print to use snacks for `:=` command
        if vim.fn.has 'nvim-0.11' == 1 then
          vim._print = function(_, ...)
            dd(...)
          end
        else
          vim.print = _G.dd
        end

        -- Create some toggle mappings
        Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
        Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
        Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'
        Snacks.toggle.diagnostics():map '<leader>ud'
        Snacks.toggle.line_number():map '<leader>ul'
        Snacks.toggle
          .option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
          :map '<leader>uc'
        Snacks.toggle.treesitter():map '<leader>uT'
        Snacks.toggle
          .option('background', { off = 'light', on = 'dark', name = 'Dark Background' })
          :map '<leader>ub'
        Snacks.toggle.inlay_hints():map '<leader>uh'
        Snacks.toggle.indent():map '<leader>ug'
        Snacks.toggle.dim():map '<leader>uD'
      end,
    })
  end,
}
