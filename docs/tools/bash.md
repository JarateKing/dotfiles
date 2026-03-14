# Bash

- prompts are a green `>` by default, and then `.` for additional lines, `?` for `select` prompts, and `+` for `set -x` lines. Above this prompt will be a line with some information, such as the current directory, which branch this is on (within a git repo), and which level of nested nix shell we're in (within NixOS).
- `notfetch` is a quick-and-simple alternative to `neofetch` and programs like it, because I didn't really like anything of the existing options.
- `show_prompts` will display each type of prompt (`$PS1-4`) as well as some information about them, useful for debugging.
- `on_dotfiles_install.sh` is a script that's meant to run on install. This will just install some key programs (ie. `git`, `emacs`) and set some default settings in gnome.
- `addfile` is a cli utility for making a copy of some predefined file. For example, `addfile .gitignore gitignore/latex` will copy over the `~/scripts/addfile_data/gitignore/latex` file (a .gitignore suited for LaTeX) and use it as `.gitignore` in the local directory.
