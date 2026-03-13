local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- use bash on windows
if (package.config:sub(1,1) == "\\") then
	config.default_prog = { "c:/Program Files/Git/bin/bash.exe", "--login", "-i" }
end

-- restyle
config.font_size = 10
config.color_scheme = "Ayu Mirage"

return config