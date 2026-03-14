local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- use bash on windows
if (package.config:sub(1,1) == "\\") then
	config.default_prog = { "c:/Program Files/Git/bin/bash.exe", "--login", "-i" }
end

-- restyle
config.font_size = 9
config.font = wezterm.font('JetBrains Mono', { weight = 'DemiBold' })
config.harfbuzz_features = {
	-- no ligatures
	'calt=0',
	'clig=0',
	'liga=0',
	-- slashed zero
	'zero',
	-- straight-angled K/k
	'cv08',
	-- less busy dollar sign
	'cv14' }
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
	},
	visual_bell = '#4b0108'
}
config.audible_bell = 'Disabled'
config.visual_bell = {
  fade_in_duration_ms = 0,
  fade_out_duration_ms = 500,
  fade_out_function = 'EaseOut'
}

-- keybinds
config.disable_default_key_bindings = true
config.keys = {
	-- copy/paste
	{
		key = 'c',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.CopyTo 'Clipboard'
	},
	{
		key = 'v',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.PasteFrom 'Clipboard'
	},
	{
		key = 'x',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.ActivateCopyMode
	},
	-- navigation
	{
		key = 'w',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.ScrollByPage(-1)
	},
	{
		key = 'a',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.ActivateTabRelative(-1)
	},
	{
		key = 's',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.ScrollByPage(1)
	},
	{
		key = 'd',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.ActivateTabRelative(1)
	},
	-- create/destroy tabs
	{
		key = 'e',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.SpawnTab 'CurrentPaneDomain'
	},
	{
		key = 'q',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.CloseCurrentPane { confirm = false }
	}
}

return config
