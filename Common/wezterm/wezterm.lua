local wezterm = require 'wezterm'
local config = wezterm.config_builder()
require('clare').apply_to_config(config)
return config
