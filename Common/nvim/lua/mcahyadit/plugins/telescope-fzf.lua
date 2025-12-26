--------------------------------------------------------
-- Helper for telescope
--------------------------------------------------------
local function normalize_path(path)
  return path:gsub('\\', '/')
end

local function normalize_cwd()
  return normalize_path(vim.loop.cwd()) .. '/'
end

local function is_subdirectory(cwd, path)
  return string.lower(path:sub(1, #cwd)) == string.lower(cwd)
end

local function split_filepath(path)
  local normalized_path = normalize_path(path)
  local normalized_cwd = normalize_cwd()
  local filename = normalized_path:match '[^/]+$'

  if is_subdirectory(normalized_cwd, normalized_path) then
    local stripped_path = normalized_path:sub(#normalized_cwd + 1, -(#filename + 1))
    return stripped_path, filename
  else
    local stripped_path = normalized_path:sub(1, -(#filename + 1))
    return stripped_path, filename
  end
end

local function path_display_name_first(_, path)
  local stripped_path, filename = split_filepath(path)
  if filename == stripped_path or stripped_path == '' then
    return filename
  end
  return string.format('%s ~ %s', filename, stripped_path)
end
--------------------------------------------------------

return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      --================
      -- Extensions
      --================
      'nvim-telescope/telescope-ui-select.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          layout_config = {
            horizontal = { preview_width = 0.6 },
          },
          path_display = path_display_name_first,
          file_ignore_patterns = {
            "%.meta",
            "%.uid",
            "%.import",
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown {},
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      pcall(require('telescope').load_extension, 'harpoon')

      --================
      -- KeyBinds
      --================
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sg', builtin.git_files)
      vim.keymap.set('n', '<leader>ff', builtin.current_buffer_fuzzy_find)
      vim.keymap.set('n', '<leader>sp', function ()
        builtin.find_files({
          hidden = true,
          follow = true
        })
      end)
      vim.keymap.set('n', '<leader>sf', function()
        builtin.grep_string { search = vim.fn.input 'Grep > ' }
      end)
      -- vim.keymap.set('n', '<leader><C-r>', builtin.oldfiles)

      -- FuzzyFind in Current File
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end)

      -- Search NeoVim Config Directory
      vim.keymap.set('n', '<leader><S-p>', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end)
    end,
  },
}
