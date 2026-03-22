# Wezterm

## Features

- Wezterm naturally supports multiplexing. We have convenient keybinds that makes creating, destroying, and navigating between tabs (or windows) easy.
- If you click a directory with the `cs` function (or generally anything that internally uses file hyperlinks, such as `ls --hyperlink`) it will run `cs` on that directory. Because this also shows the contents of that directory, this can be used to navigate between directories via the mouse.

## Keybinds

All keybinds are done with either `CTRL+SHIFT` or `CTRL+SHIFT+ALT`, where `ALT` is either a variant or a more "extreme" version of the same keybind (ie. instead of scrolling up some, scroll to the top).

- `W`: scrolls up half the screen. Alt scrolls to the top.
- `A`: moves to the previous tab. Alt moves to the previous window.
- `S`: scrolls down half the screen. Alt scrolls to the bottom.
- `D`: moves to the next tab. Alt moves to the next window.
- `E`: spawns a new tab. Alt spawns a new window.
- `Q`: quits the current pane, or tab if only one pane, or window if only one tab.
- `C`: copies the selected text.
- `V`: pastes from the clipboard.
- `F`: enters "find" mode. Alt enters "quick select" mode.
- `X`: enters "copy" mode for selecting text via the keyboard.
- `R`: opens menu to select unicode/emoji/nerdfont/etc. characters.
- `P`: opens menu to select wezterm commands.

As well, `F11` (with no modifiers) will toggle fullscreen mode.

