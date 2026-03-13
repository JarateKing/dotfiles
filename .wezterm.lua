local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- use bash on windows
if (package.config:sub(1,1) == "\\") then
	config.default_prog = { "c:/Program Files/Git/bin/bash.exe", "--login", "-i" }
end

-- restyle
config.font_size = 10
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
config.use_fancy_tab_bar = false
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.color_scheme = "Ayu Mirage"
config.colors = {
	background = '#0B1118',
	tab_bar = {
		background = '#0B1118',
		active_tab = {
			bg_color = '#113354',
			fg_color = 'silver'
		},
		inactive_tab = {
			bg_color = '#0B1118',
			fg_color = 'silver'
		},
		inactive_tab_hover = {
			bg_color = '#0B1118',
			fg_color = 'white'
		
		},
		new_tab = {
			bg_color = '#0B1118',
			fg_color = 'silver'
		},
		new_tab_hover = {
			bg_color = '#0B1118',
			fg_color = 'white'
		}
	}
}

return config
