local wezterm = require("wezterm") ---@type Wezterm
local module = {} ---@type Config
local launch_menu = {}

if wezterm.target_triple:find("windows") ~= nil then
	home_dir = os.getenv("USERPROFILE")
	-- table.insert(launch_menu, {
	--   label = 'WeaSeL',
	--   args = { 'wsl.exe' },
	-- })
	table.insert(launch_menu, {
		label = "PowerShell",
		args = { "pwsh.exe", "-nol" },
	})
	table.insert(launch_menu, {
		label = "CMD",
		args = { "cmd.exe" },
	})
	table.insert(launch_menu, {
		label = "Git-Bash For Windows",
		args = { home_dir .. "/scoop/shims/bash.exe", "-l" },
	})
end

function module.apply_to_config(config)
	config.launch_menu = module.launch_menu
	config.default_prog = module.launch_menu[1].args
end

module.launch_menu = launch_menu
return module
