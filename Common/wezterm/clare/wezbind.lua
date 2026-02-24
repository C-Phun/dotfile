local wezterm = require 'wezterm' ---@type Wezterm
local module = {} ---@type Config

local function smart_close(window, pane)
  local tab = window:active_tab()
  local panes = tab:panes()

  if #panes <= 1 then
    window:perform_action(wezterm.action.CloseCurrentTab { confirm = false }, pane)
  else
    window:perform_action(wezterm.action.CloseCurrentPane { confirm = false }, pane)
  end
end

module.leader = { key = 'a', mods = 'CTRL' }
module.keys = {
  {
    key = '-',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = '=',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'Enter',
    mods = 'ALT',
    action = wezterm.action.ToggleFullScreen,
  },
  {
    key = 'c',
    mods = 'LEADER',
    action = wezterm.action.SpawnTab 'CurrentPaneDomain',
  },
  {
    key = 'q',
    mods = 'LEADER',
    action = wezterm.action_callback(smart_close),
  },
  {
    key = 'c',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.CopyTo 'Clipboard',
  },
  {
    key = 'v',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.PasteFrom 'Clipboard',
  },
  {
    key = '=',
    mods = 'CTRL',
    action = wezterm.action.IncreaseFontSize,
  },
  {
    key = '-',
    mods = 'CTRL',
    action = wezterm.action.DecreaseFontSize,
  },
  {
      key = 't',
      mods = 'LEADER',
      action = wezterm.action.TogglePaneZoomState,
  },
}

for i = 1, 9 do
  table.insert(module.keys, {
    key = tostring(i),
    mods = 'CTRL',
    action = wezterm.action.ActivateTab(i - 1),
  })
end

function module.apply_to_config(config)
  config.disable_default_key_bindings = true
  config.leader = module.leader

  if config.keys == nil then
    config.keys = module.keys
  else
    for _, val in pairs(module.keys) do
      table.insert(config.keys, val)
    end
  end
end

return module
