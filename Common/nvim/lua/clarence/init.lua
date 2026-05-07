require 'clarence.keymap'
require 'clarence.config'
require 'clarence.lazy'

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

function moveToFront(bufnr, in_pane)
  if not in_pane then
    local last_window = vim.fn.winnr('#')
    vim.api.nvim_set_current_win(vim.fn.win_getid(last_window))
  end

  if vim.fn.buflisted(bufnr) == 1 then
    vim.cmd('buffer ' .. bufnr)

    local bufferline = require 'bufferline'
    local found = false
    for _, e in ipairs(bufferline.get_elements().elements) do
      if found then
        bufferline.move(1)
      else
        found = e.id == bufnr
      end
    end
  else
    vim.cmd('edit #' .. bufnr)
  end
end

vim.api.nvim_create_autocmd({"VimEnter"}, {
    callback = function(event)
        local title = string.format("%s", vim.fs.basename(vim.fn.getcwd()))
        vim.fn.system({"wezterm", "cli", "set-tab-title", title})
    end,
})

vim.api.nvim_create_autocmd({"VimLeave"}, {                       
    callback = function()                                  
        -- Setting title to empty string causes wezterm to revert to its
        -- default behavior of setting the tab title automatically       
        vim.fn.system({"wezterm", "cli", "set-tab-title", ""})
    end,                                                          
})     
