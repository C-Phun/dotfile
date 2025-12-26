vim.g.have_nerd_font = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.scrolloff = 25

vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.smartindent = true

vim.o.wrap = false

vim.o.breakindent = true

vim.o.swapfile = false

-- Smart Case-Sensitivity for searching `/`
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.exrc = true

local os = vim.loop.os_uname().sysname
if os:find 'MINGW' then
  vim.opt.shell = 'cmd'
  vim.opt.shellcmdflag = string.format(
    'C:\\msys64\\msys2_shell.cmd -defterm -here -no-start -%s -shell %s',
    string.lower(vim.env.MSYSTEM),
    vim.env.SHELL:match '([^/]+)$'
  )
end
if os:find 'Windows' then
  vim.opt.shell = vim.fn.executable 'pwsh' and 'pwsh' or 'powershell'
  vim.opt.shellcmdflag =
    '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
  vim.opt.shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait'
  vim.opt.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  vim.opt.shellquote = ''
  vim.opt.shellxquote = ''
end
