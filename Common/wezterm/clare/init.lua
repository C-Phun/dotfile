local wezterm = require("wezterm")
local module = {}

function module.apply_to_config(config)
	require("clare.wezbind").apply_to_config(config)
	require("clare.wezprofile").apply_to_config(config)
	require("clare.wezsplit").apply_to_config(config)
	config.font = wezterm.font({
		family = "CaskaydiaCove Nerd Font",
		harfbuzz_features = { "calt", "ss01", "ss02", "ss03", "ss19", "ss20" },
	})
	config.font_size = 12
	config.window_background_opacity = 0.90
	config.window_close_confirmation = "NeverPrompt"
	config.color_scheme = "Sonokai (Gogh)"
	-- config.hide_tab_bar_if_only_one_tab = true
	-- config.enable_tab_bar = false
	config.window_decorations = "RESIZE"
	config.window_padding = {
		top = 0,
		bottom = 0,
		left = 0,
		right = 0,
	}

	wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm").apply_to_config(config, {
		position = "top",
	})
	config.colors = {
		tab_bar = {
			background = "#000000",
		},
	}

	config.adjust_window_size_when_changing_font_size = false
end

return module
