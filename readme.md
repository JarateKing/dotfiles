###### This readme can be run on command line or piped into curl as an installer. Doing so will run the following commands:

    echo 'installing dotfiles'
    
    # download this repo
    cd ~/
    rm -rf ./dotfiles
    git clone https://github.com/JarateKing/dotfiles.git ./dotfiles
    
    # setup in home directory
    chmod -R 755 ./dotfiles
    rsync -a --remove-source-files ./dotfiles/ ./
    rm -rf ./dotfiles
    git submodule update --init --recursive
    
    # run install script
    ~/scripts/on_dotfiles_install.sh
    
    # finish up
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

There are also some fonts that ideally should be installed:
- install https://github.com/davestewart/minimap-font/tree/master
- install https://www.jetbrains.com/lp/mono/

#### Windows

For the most part these dotfiles can be installed on windows as well, by cloning this repo into the user's home directory (usually `c:/Users/<username>/`). Not everything is guaranteed to work, but most should.

Emacs on windows usually looks for `.emacs.d` in `%APPDATA%` rather than in the user's home directory. The easy way around this is with a symlink: `mklink "%AppData%\.emacs.d" "%UserProfile%\.emacs.d"`. Similar must be done for neovim: `mklink "%LocalAppData%\nvim" "%UserProfile%\.config\nvim"`.

These dotfiles on windows do assume that git is installed and git-bash is found at `c:/Program Files/Git/bin/bash.exe`.

### Modifying

If you wish to make changes to any files that have already been included, feel free! You can then commit and push them through git as usual.

If you're adding new files, you may need to add them to `.gitignore`, in a format like `!.bashrc` to tell git to specifically *not* ignore these files (as our `.gitignore` ignores everything by default). We use `.gitignore` to keep our git statuses clean, but it does mean we need to manually unignore things when we add them.

## Documentation

Further documentation can be found within the [docs directory](/docs) in this repo. This includes information about specific tools, as well as more meta-level documentation like the design philosophy of this dotfiles management style.
