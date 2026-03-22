# My Workflow

This document describes how I tend to use the various commands and features in these dotfiles.

## Use Cases

### Terminal Navigation

... zellij for ... Otherwise, when each task is a bit more separated, I'll create different tabs in wezterm (via `CTRL+SHIFT+E` to spawn a new tab and `CTRL+SHIFT+A`/`D` to navigate to it) and use them that way.

To navigate directories, I'll either use `cs` (which is like `cd` that also runs `ls` and may run `git status` afterwards, since I'd usually run those anyway after `cd`) if I know exactly what directory to go to, or I'll use `cz` (which uses `yazi`) which is better for browsing directories if I need to go looking around more.

### Editing

I use both emacs and neovim for different purposes. The easiest way to think of it is that emacs is my IDE, neovim is my notepad. I'll run neovim if I just need to make a quick edit to a file and close it right after, including things like commit messages. Emacs is more oriented towards full development.

## Example

Let's say I want to do some programming on a git project named `website`. I might:

- run `cz` to open `yazi` and navigate to the `website` root directory.
- `ctrl+shift+e` to spawn a new tab and go to it.
- run `_emacs` to do development on `website`. Let's say I made some changes in the `src/pages/` directory.
- `ctrl+shift+a` to return to the previous tab.
- run `cs src/pages` to go to the directory that I've made changes in.
- run `gitu` to stage changes and make a commit.
- making that commit will run `nvim`, where I write the commit message in neovim.

