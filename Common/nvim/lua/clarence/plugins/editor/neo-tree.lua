local nesting_rules_ = {

  ['.git'] = {
    files = {
      '%.gitignore',
      '%.gitattributes',
      '%.gitmodules',
      '%.lfsconfig',
      '%.mailmap',
      '%.git-blame*',
      '%.pre-commit-config.yaml',
    },
    pattern = '%.git$',
  },
  ['.gitignore'] = {
    files = {
      '%.gitattributes',
      '%.gitmodules',
      '%.lfsconfig',
      '%.mailmap',
      '%.git-blame*',
      '%.pre-commit-config.yaml',
    },
    pattern = '%.gitignore$',
  },
  ['README.*'] = {
    files = {
      'AUTHORS',
      'BACKERS*',
      'CHANGELOG*',
      'CITATION*',
      'CODE_OF_CONDUCT*',
      'CODEOWNERS',
      'CONTRIBUTING*',
      'CONTRIBUTORS',
      'COPYING*',
      'CREDITS',
      'GOVERNANCE%.MD',
      'HISTORY%.MD',
      'LICENSE*',
      'MAINTAINERS',
      'README_*',
      'RELEASE_NOTES*',
      'ROADMAP%.MD',
      'SECURITY%.MD',
      'SPONSORS*',
      'README-*',
    },
    ignore_case = true,
    pattern = 'README%.(.*)$',
  },
  ------------------
  -- C/C++
  ------------------
  ['*.c'] = {
    files = { '%1%.h' },
    pattern = '(.*)%.c$',
  },
  ['*.cpp'] = {
    files = { '%1%.hpp', '%1%.h' },
    pattern = '(.*)%.cpp$',
  },
  ['*.cc'] = {
    files = { '%1%.hpp', '%1%.h' },
    pattern = '(.*)%.cc$',
  },
  ['.clangd'] = {
    files = { '.clang-format', '.clang-tidy', 'compile_commands.json' },
    pattern = '%.clangd$',
  },
  ['*.zig'] = {
    files = { '%1%.zig.zon' },
    pattern = '(.*)%.zig$',
  },
  -- ['.clang-format'] = {
  --   files = { '%.clang-tidy' },
  --   pattern = '%.clang%-format$'
  -- },
  ['CMake'] = {
    files = { 'CMakeSettings.json' },
    pattern = 'CMakeLists%.txt$',
  },
  ['SCons'] = {
    files = { '.sconsign.dblite' },
    pattern = 'SConstruct',
  },
  ['*.vcxproj'] = {
    files = { '%1%.vcxproj.filters', '%1%.vcxproj.user' },
    pattern = '(.*)%.vcxproj$',
  },
  ------------------
  -- C#
  ------------------
  ['*.sln'] = {
    files = {
      '%1%.sln.DotSettings.user',
      '*%.vcxproj',
      '*%.csproj',
      '.filenestings.json',
      'packages.lock.json',
    },
    pattern = '(.*)%.sln$',
  },
  ['*.csproj'] = {
    files = { 'packages.lock.json' },
    pattern = '(.*)%.csproj$',
  },
  ------------------
  ['docker'] = {
    files = { '.dockerignore' },
    pattern = 'dockerfile$',
    ignore_case = true,
  },
  ['flake.nix'] = {
    files = { 'flake.lock', 'default.nix', 'shell.nix' },
    pattern = 'flake%.nix$',
  },
  ['meta'] = {
    files = { '%1%.meta', '%1%.uid', '%1%.import', '%1%.bak' },
    pattern = '^(.*)$',
  },
  -- nest_meta_files,
}

-- if kTermux then
if false then
  return {}
else
  return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'echasnovski/mini.nvim',
    },
    lazy = false, -- neo-tree will lazily load itself
    opts = function(_, opts)
      local function on_move(data)
        Snacks.rename.on_rename_file(data.source, data.destination)
      end
      local events = require 'neo-tree.events'
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })
    end,
    config = function()
      local highlights = require 'neo-tree.ui.highlights'
      require('neo-tree').setup {
        nesting_rules = nesting_rules_,
        filesystem = {
          filtered_items = {
            visible = true,
          },
          use_libuv_file_watcher = true,
          default_component_configs = {
            symlink_target = { enabled = true },
          },
          follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
          },
          components = {
            icon = function(config, node, state)
              local icon = config.default or ' '
              local padding = config.padding or ' '
              local highlight = config.highlight or highlights.FILE_ICON

              if node.type == 'directory' then
                highlight = highlights.DIRECTORY_ICON
                if node:is_expanded() then
                  if string.match(node.name, '^%.') then
                    icon = '󰷏'
                  else
                    icon = config.folder_open
                  end
                else
                  local icon_m, hl, is_default = MiniIcons.get('directory', node.name)
                  if icon_m ~= nil and is_default == false then
                    icon = icon_m
                  elseif string.match(node.name, '^%.') then
                    icon = '󰉖'
                  else
                    icon = config.folder_closed
                  end
                end
              elseif node.type == 'file' then
                local success, web_devicons = pcall(require, 'nvim-web-devicons')
                if success then
                  local devicon, hl = web_devicons.get_icon(node.name, node.ext)
                  icon = devicon or icon
                  highlight = hl or highlight
                end
              end
              return {
                text = icon .. padding,
                highlight = highlight,
              }
            end,
          },
        },
        event_handlers = {
          {
            event = 'file_open_requested',
            handler = function()
              require('neo-tree.command').execute { action = 'close' }
            end,
          },
        },
      }
      vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<cr>')
      vim.keymap.set('n', '<leader>-', function()
        local reveal_file = vim.fn.expand '%:p'
        if reveal_file == '' then
          reveal_file = vim.fn.getcwd()
        else
          local f = io.open(reveal_file, 'r')
          if f then
            f.close(f)
          else
            reveal_file = vim.fn.getcwd()
          end
        end
        require('neo-tree.command').execute {
          action = 'focus', -- OPTIONAL, this is the default value
          source = 'filesystem', -- OPTIONAL, this is the default value
          position = 'left', -- OPTIONAL, this is the default value
          reveal_file = reveal_file, -- path to file or folder to reveal
          reveal_force_cwd = true, -- change cwd without asking if needed
        }
      end, { desc = 'Open neo-tree at current file or working directory' })
    end,
  }
end
