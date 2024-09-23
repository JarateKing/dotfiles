###### This readme can be run on command line or piped into curl as an installer. Doing so will run the following commands:

    echo 'installing dotfiles'
    cd ~/
    rm -rf ./dotfiles
    git clone https://github.com/JarateKing/dotfiles.git ./dotfiles
    rsync -a --remove-source-files ./dotfiles/ ./
    rm -rf ./dotfiles
    git submodule update --init --recursive
    echo 'done! Please restart your computer'
    exit 0

The intended usage of this is `curl -s https://raw.githubusercontent.com/JarateKing/dotfiles-nix/master/readme.md | sh` to automatically setup dotfiles. The remainder of this readme is a standard description of this repo.

# NixOS Dotfiles

This repo includes my dotfiles used for NixOS.

## Emacs

Setup:

- the first run will spend time getting packages and thus have a slow startup
- when you're able, run `M-x all-the-icons-install-fonts` once

