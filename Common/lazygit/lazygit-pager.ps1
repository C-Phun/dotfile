#!/usr/bin/env -S pwsh -noprofile

$old = $args[1].Replace('\', '/')
$new = $args[4].Replace('\', '/')
$path = $args[0]
git diff --no-index --no-ext-diff $old $new
  | %{ $_.Replace($old, $path).Replace($new, $path) }
  | delta --syntax-theme="gruvbox-dark" --width=$env:LAZYGIT_COLUMNS --paging=never
