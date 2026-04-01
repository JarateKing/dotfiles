# Bash

## Basics

- prompts are a green `>` by default, and then `.` for additional lines, `?` for `select` prompts, and `+` for `set -x` lines. Above this prompt will be a line with some information, such as the current directory, which branch this is on (within a git repo), and which level of nested nix shell we're in (when using nix).
- The `cs` command is intended to replace both `cd` and `ls`. With an argument (ie. `cs ~`) it'll `cd` to that directory and then show additional info such as `ls`. Without an argument it'll act like `ls` with better defaults. `cs -` will go to the previous directory.
- The `cse` command extends this further. With a directory argument it'll act the same, but with a file argument it'll open it in neovim.
- The `cz` command is similar, but uses `yazi` to navigate between directories. This is more convenient to browse directories as it's a full filemanager, but likely isn't as fast to directly go to a specific directory.
- `q` will `exit` as a minor convenience.
- `__` can be used mid-pipe to comment something out, ie. `ls | __ sort -nr | grep .md` will still `ls | grep .md` but ignore the `sort -nr` since it's been commented out.

## Utilities

- `clears` will clear the screen, but preserve full history (unlike `clear`, and including what's currently on screen unlike `clear -x`).
- `notfetch` is a quick-and-simple alternative to `neofetch` and programs like it, because I didn't really like anything of the existing options.
- `show_prompts` will display each type of prompt (`$PS1-4`) as well as some information about them, useful for debugging.
- `on_dotfiles_install.sh` is a script that's meant to run on install. This will just install some key programs (ie. `git`, `emacs`) and set some default settings in gnome.
- `addfile` is a cli utility for making a copy of some predefined file. For example, `addfile .gitignore gitignore/latex` will copy over the `~/scripts/addfile_data/gitignore/latex` file (a .gitignore suited for LaTeX) and use it as `.gitignore` in the local directory.
- `reload_bashrc` can be used to load any edits made to `.bashrc`.
- likewise with `reload_inputrc`.
- `gitlogs` will show a git log that's suited for surface-level overviews.
- `gitlogx` is similar but shows more extended information suited for analyzing individual commits.

## Nix Shells

- `_emacs` will start up emacs with any other programs it might use (ie. LSP servers).
- `_art` will provide various tools useful for making art assets (ie. krita, blender, aseprite, etc.).
