# Bash

## Basics

- prompts are a green `>` by default, and then `.` for additional lines, `?` for `select` prompts, and `+` for `set -x` lines. Above this prompt will be a line with some information, such as the current directory, which branch this is on (within a git repo), and which level of nested nix shell we're in (when using nix).
- The `cs` command is intended to replace both `cd` and `ls`. With an argument (ie. `cs ~`) it'll `cd` to that directory and then show additional info such as `ls`. Without an argument it'll act like `ls` with better defaults. `cs -` will go to the previous directory.
- Many variations of `cs`: `cse` will also edit in neovim if the target is a file. `cz` will use yazi to move between directories. `mkcs` will make the target directory first if it doesn't exist. `tempcs` will create a new tmp directory and move to that.
- `q` will `exit` as a minor convenience.
- `__` can be used mid-pipe to comment something out, ie. `ls | __ sort -nr | grep .md` will still `ls | grep .md` but ignore the `sort -nr` since it's been commented out.

## Utilities

Some of these utilities are useful for configuring a terminal, others are generally useful utilities for working in bash, and some are just useful random scripts to solve tasks that come up every so often.

- `addfile` is a cli utility for making a copy of some predefined file. For example, `addfile .gitignore gitignore/latex` will copy over the `~/scripts/addfile_data/gitignore/latex` file (a .gitignore suited for LaTeX) and use it as `.gitignore` in the local directory.
- `args` and `nargs` will list each of the arguments of the command that follows it. `args` will just list each argument on a new line, `nargs` will include line numbers.
- `clears` will clear the screen, but preserve full history (unlike `clear`, and including what's currently on screen unlike `clear -x`).
- `dict_search` will grab a word list and match each word against regex.
- `gen_password` will generate random (base64) characters. A number argument can be supplied to set the number of characters (default 8).
- `list_paths` will list each entry in `$PATH` as well as how many files that directory contains.
- `notfetch` is a quick-and-simple alternative to `neofetch` and programs like it, because I didn't really like anything of the existing options.
- `on_dotfiles_install.sh` is a script that's meant to run on install. This will just install some key programs (ie. `git`, `emacs`) and set some default settings in gnome.
- `palette` will show the terminal's ANSI escape sequence colours, in a nice clean palette.
- `reload_bashrc` can be used to load any edits made to `.bashrc`.
- `show_prompts` will display each type of prompt (`$PS1-4`) as well as some information about them, useful for debugging.
- `todo` will open `.todo.txt` (a globally gitignored file) in neovim, to write down any personal todos or notes.
- `verbose` will show the commands run in the script argument (ie. `verbose palette`) via `set -x`.
- likewise with `reload_inputrc`.

## Nix Shells

- `_emacs` will start up emacs with any other programs it might use (ie. LSP servers).
- `_art` will provide various tools useful for making art assets (ie. krita, blender, aseprite, etc.).
