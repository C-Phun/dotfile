vim.g.mapleader = ' '

vim.keymap.set('n', '<leader><S-r>', function()
  vim.cmd 'source $MYVIMRC'
  vim.cmd 'Lazy sync'
end, { desc = 'Reload Neovim configuration' })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set(
  'n',
  '<leader>q',
  vim.diagnostic.setloclist,
  { desc = 'Open diagnostic [Q]uickfix list' }
)
-- vim.keymap.set('n', '<leader>e', vim.cmd.Ex)
vim.keymap.set({ 'n', 'v' }, '<leader>cc', 'gc', { remap = true })

vim.keymap.set('n', '<C-A-down>', '<cmd>belowright split<cr><c-w>j')
vim.keymap.set('n', '<C-A-j>', '<cmd>belowright split<cr><c-w>j')

vim.keymap.set('n', '<C-A-up>', '<cmd>split<cr><c-w>k')
vim.keymap.set('n', '<C-A-k>', '<cmd>split<cr><c-w>k')

vim.keymap.set('n', '<C-A-right>', '<cmd>belowright vertical split<cr><c-w>l')
vim.keymap.set('n', '<C-A-l>', '<cmd>belowright vertical split<cr><c-w>l')

vim.keymap.set('n', '<C-A-left>', '<cmd>vertical split<cr><c-w>h')
vim.keymap.set('n', '<C-A-h>', '<cmd>vertical split<cr><c-w>h')

vim.keymap.set('n', '<S-j>', '<cmd>bprev<cr>')
vim.keymap.set('n', '<S-k>', '<cmd>bnext<cr>')
vim.keymap.set('n', '<S-q>', '<cmd>bd<cr>')

vim.keymap.set({ 'n', 'v', 'x' }, 'y', '"+y<cr>')
vim.keymap.set({ 'n', 'v' }, 'p', '"+p<cr>')

-- vim.g.VM_default_mappings   = 0

vim.keymap.set('n', '<C-q>', function()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(bufnr) and not vim.api.nvim_buf_get_option(bufnr, 'modified') then
      local winid = vim.fn.bufwinnr(bufnr)
      if winid == -1 then
        vim.cmd(string.format('%dbd', bufnr))
      end
    end
  end
end, { desc = 'Clean Buffers' })
