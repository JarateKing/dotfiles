local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- use bash on windows
if (package.config:sub(1,1) == "\\") then
	config.default_prog = { "c:/Program Files/Git/bin/bash.exe", "--login", "-i" }
end

-- restyle
config.font_size = 9
config.char_select_font_size = 9
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
config.show_tab_index_in_tab_bar = false
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
config.char_select_bg_color = "#0B1118"
config.char_select_fg_color = "silver"
config.audible_bell = 'Disabled'
config.visual_bell = {
  fade_in_duration_ms = 0,
  fade_out_duration_ms = 500,
  fade_out_function = 'EaseOut'
}
wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
	return ' ' .. (tab.tab_index + 1) .. ' '
  end
)

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
		action = wezterm.action.ScrollByPage(-0.5)
	},
	{
		key = 'w',
		mods = 'CTRL|SHIFT|ALT',
		action = wezterm.action.ScrollToTop
	},
	{
		key = 'a',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.ActivateTabRelative(-1)
	},
	{
		key = 'a',
		mods = 'CTRL|SHIFT|ALT',
		action = wezterm.action.ActivateWindowRelative(-1)
	},
	{
		key = 's',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.ScrollByPage(0.5)
	},
	{
		key = 's',
		mods = 'CTRL|SHIFT|ALT',
		action = wezterm.action.ScrollToBottom
	},
	{
		key = 'd',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.ActivateTabRelative(1)
	},
	{
		key = 'd',
		mods = 'CTRL|SHIFT|ALT',
		action = wezterm.action.ActivateWindowRelative(1)
	},
	{
		key = 'f',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.Search 'CurrentSelectionOrEmptyString'
	},
	-- create/destroy tabs/windows
	{
		key = 'e',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.SpawnTab 'CurrentPaneDomain'
	},
	{
		key = 'e',
		mods = 'CTRL|SHIFT|ALT',
		action = wezterm.action.SpawnWindow
	},
	{
		key = 'q',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.CloseCurrentPane { confirm = false }
	},
	-- misc
	{
		key = 'F11',
		action = wezterm.action.ToggleFullScreen
	},
	{
		key = 'r',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.CharSelect
	}
}

-- directory/file hyperlink support
-- modified from wezterm.org/recipes/hyperlinks.html#configuration
local function is_shell(foreground_process_name)
    local shell_names = { 'bash', 'bash.exe', 'zsh', 'zsh.exe', 'fish', 'fish.exe', 'sh', 'sh.exe', 'ksh', 'ksh.exe', 'dash', 'dash.exe' }
    local process = string.match(foreground_process_name, '[^/\\]+$')
        or foreground_process_name
    for _, shell in ipairs(shell_names) do
        if process == shell then
            return true
        end
    end
    return false
end
wezterm.on('open-uri', function(window, pane, uri)
    local editor = 'nvim'
    if uri:find '^file:' == 1 and not pane:is_alt_screen_active() then
        -- We're processing an hyperlink and the uri format should be: file://[HOSTNAME]/PATH[#linenr]
        -- Also the pane is not in an alternate screen (an editor, less, etc)
        local url = wezterm.url.parse(uri)
        if is_shell(pane:get_foreground_process_name()) then
            pane:send_text(
				wezterm.shell_join_args { 'cse', url.file_path } .. '\r'
			)
        else
            -- No shell detected, we're probably connected with SSH, use fallback command
            local edit_cmd = url.fragment
                    and editor .. ' +' .. url.fragment .. ' "$_f"'
                or editor .. ' "$_f"'
            local cmd = '_f="'
                .. url.file_path
                .. '"; { test -d "$_f" && { cd "$_f" ; ls -a -p --hyperlink --group-directories-first; }; } '
                .. '|| { test "$(file --brief --mime-type "$_f" | cut -d/ -f1 || true)" = "text" && '
                .. edit_cmd
                .. '; }; echo'
            pane:send_text(cmd .. '\r')
            return false
        end
    end
end)

return config
