###### This readme can be run on command line or piped into curl as an installer. Doing so will run the following commands:

    echo 'installing dotfiles'
    cd ~/
    rm -rf ./dotfiles
    git clone https://github.com/JarateKing/dotfiles.git ./dotfiles
    chmod -R 755 ./dotfiles
    rsync -a --remove-source-files ./dotfiles/ ./
    rm -rf ./dotfiles
    git submodule update --init --recursive
    ~/scripts/on_dotfiles_install.sh
    echo 'done! Please restart your computer'
    exit 0

The intended usage of this is `curl -s https://raw.githubusercontent.com/JarateKing/dotfiles/refs/heads/master/readme.md | sh` to automatically setup dotfiles. The remainder of this readme is a standard description of this repo.

---

# Dotfiles

This repo includes my dotfiles. My current setup is based on Fedora with nix as the package manager (which is installed alongside these dotfiles through the install script). This should be easily transfered to other distros, but I can't guarantee everything will work. I've attempted to make things fairly usable and general-purpose, but as they're dotfiles they are very opinionated.

## Usage

### Installing

Run the install script (this `readme.md` file) from anywhere. If you've manually cloned this repo to a location other than your home directory, you'll end up with an additional repo. As mentioned above, the intended usage is by running this file via `curl`.

Manual installation can be done by cloning or downloading this repo and moving it to the home directory yourself.

When you're done installing, you can optionally delete the `.git` folder, `.gitignore`, and `readme.md` files. Doing so would mean your dotfiles are no longer under source control, but would still be functional as dotfiles.

### Modifying

If you wish to make changes to any files that have already been included, feel free! You can then commit and push them through git as usual.

If you're adding new files, you may need to add them to `.gitignore`, in a format like `!.bashrc` to tell git to specifically *not* ignore these files (as our `.gitignore` ignores everything by default).

## Contents

### Bash

- prompts are a green `>` by default, and then `.` for additional lines, `?` for `select` prompts, and `+` for `set -x` lines. Above this prompt will be a line with some information, such as the current directory, which branch this is on (within a git repo), and which level of nested nix shell we're in (within NixOS).
- `notfetch` is a quick-and-simple alternative to `neofetch` and programs like it, because I didn't really like anything of the existing options.
- `show_prompts` will display each type of prompt (`$PS1-4`) as well as some information about them, useful for debugging.
- `on_dotfiles_install.sh` is a script that's meant to run on install. This will just install some key programs (ie. `git`, `emacs`) and set some default settings in gnome.

### Emacs

My personal emacs config. Based off of James Cherti's [minimal .emacs.d](https://github.com/jamescherti/minimal-emacs.d) setup.

Setup:

- the first run will spend time getting packages and thus have a slow startup
- when you're able, run `M-x all-the-icons-install-fonts` once
- install https://github.com/davestewart/minimap-font/tree/master
- install https://www.jetbrains.com/lp/mono/

Running `_emacs` on NixOS will automatically include LSP servers and any external tools needed. It will have a longer startup time though, so regular `emacs` is suited more for quick edits while `_emacs` is suitable as an IDE.

Some important notes:
- supports TUI mode, but with some features (project tree, minimap) disabled.
- `EMACS_LSP` must be defined to use `lsp-mode`. This will be defined when `_emacs` is run.
- `EMACS_LLM` must be defined to use `gptel`. This will be defined when `_emacs` is run, along with running `ollama` with a local model in the background automatically. I don't personally use this (and have many complaints about LLMs), but I wanted to be informed about LLM use cases and was interested in the process to set it up and experiment with it, so I kept it included here. With this, there are several different keybinds that begin with `C-o` (for ollama) that handle many common use cases.
- `C-<tab>` will cycle through displaying different information, ie. visible whitespace.
- `C-t` will open a terminal emulator, which will automatically go away when you `exit` the shell.
- a lot of common editor keybinds (copy/paste/cut, save, find, undo/redo) use the de facto standard instead of emacs conventions.

### Neovim

I've fiddled around with making a neovim config, intended primarily for quick edits on the commandline rather than a full-fledged IDE to live in (that's what emacs is for) or anything like that. I primarily use emacs so the neovim config isn't as fleshed-out, but it is available.

That is to say neovim isn't meant to replace emacs or fill the same niche, the configs aren't meant to be similar. Some things are going to be comparable (ie. neovim's `oil` is similar to emacs' `dired`) but I'm intentionally keeping other things different (ie. my emacs config has a sidepanel filetree, neovim doesn't) to fit their role better.

## Philosophy

There's a few things I wanted out of a dotfiles repo:

1. To be managed with source control directly in the home directory. I did not want to have my dotfiles without any source control, or have actual dotfiles be in one place and attempt to replicate them under source control in a repo somewhere else, I didn't want to deal with the potential headache of symlinks, etc.
2. To not require any sort of tooling or significantly transformative steps to install. Convenience in the form of an install script is fine, but I wanted this install process to be very simple and totally viable to do manually.
3. To have as little amount of clutter as possible while doing the above.
4. To not be too strongly tied to any one specific distro.

For this reason, our dotfiles are mostly just stored as-is, with a repo directly in the home directory, with a few additional files required:

- a `readme.md` that describes the repo, documents the dotfiles, and acts as an install script
- `.gitignore` to handle filtering files in/out of the repo, making managing dotfiles under source control much easier

One concern was that this would mean every subdirectory in the home directory would also consider itself a part of the dotfiles repo, but we were able to solve this by setting `GIT_CEILING_DIRECTORIES` and make it so that git only recognizes the dotfiles repo if our working directory is home, any subdirectories won't search the home directory for `.git`.

All in all we end up with a fairly minimal setup that doesn't require much dependencies (namely, `git` itself to clone this repo, and even that's optional).
