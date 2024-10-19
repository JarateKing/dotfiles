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

## Contents

### Emacs

Setup:

- the first run will spend time getting packages and thus have a slow startup
- when you're able, run `M-x all-the-icons-install-fonts` once
- install https://github.com/davestewart/minimap-font/tree/master
- install https://www.jetbrains.com/lp/mono/
