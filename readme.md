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

# NixOS Dotfiles

This repo includes my dotfiles used for NixOS.

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

- prompts are a green `>` by default, and then `.` for additional lines, `?` for `select` prompts, and `+` for `set -x` lines. In NixOS using nix shells, the prompt will be prefaced with the shell depth in grey.
- `notfetch` is a quick-and-simple alternative to `neofetch` and programs like it, because I didn't really like anything of the existing options.
- `show_prompts` will display each type of prompt (`$PS1-4`) as well as some information about them, useful for debugging.
- `on_dotfiles_install.sh` is a script that's meant to run on install. This will just set some default settings in gnome.

### Emacs

Setup:

- the first run will spend time getting packages and thus have a slow startup
- when you're able, run `M-x all-the-icons-install-fonts` once
- install https://github.com/davestewart/minimap-font/tree/master
- install https://www.jetbrains.com/lp/mono/

## Philosophy

There's a few things I wanted out of a dotfiles repo:

1. To be managed with source control directly in the home directory. I did not want to have my dotfiles without any source control, or have actual dotfiles be in one place and attempt to replicate them under source control in a repo somewhere else, I didn't want to deal with the potential headache of symlinks, etc.
2. To not require any sort of tooling or significantly transformative steps to install. Convenience in the form of an install script is fine, but I wanted this install process to be very simple and totally viable to do manually.
3. To have as little amount of clutter as possible while doing the above.

For this reason, our dotfiles are mostly just stored as-is, with a repo directly in the home directory, with a few additional files required:

- a `readme.md` that describes the repo, documents the dotfiles, and acts as an install script
- `.gitignore` to handle filtering files in/out of the repo, making managing dotfiles under source control much easier

All in all we end up with a fairly minimal setup that doesn't require much dependencies (namely, `git` itself).
