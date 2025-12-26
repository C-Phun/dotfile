vim.filetype.add {
  pattern = {
    ['.*/User/.*%.json'] = 'jsonc',
    ['.*/%.vscode/.*%.json'] = 'jsonc',
    ['.*/yum%.repos%.d/.*%.repo'] = 'ini',
    ['config'] = 'ini',
  },
  extension = {
    gdextension = 'gdresource',
    godot = 'gdresource',
    gdignore = 'gitignore',
    asmdef = 'json',
    meta = 'yaml',
    import = 'ini',

    razor = 'razor', -- Why?? lmao
    -- cshtml = 'razor'
    kbd = 'lisp',
  },
}
