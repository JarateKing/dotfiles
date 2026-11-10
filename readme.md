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

There are some (optional) post-install steps. Check [the documentation](/docs/postinstall.md) for details.

#### Windows

For the most part these dotfiles can be installed on windows as well, by cloning this repo into the user's home directory (usually `c:/Users/<username>/`). Not everything is guaranteed to work, but most should.

Some programs (ie. emacs, nvim) expect configuration in `%APPDATA%` rather than the home directory. We can use symlinks for this. Run `scripts/windows_setup_symlinks.bat` with admin privileges and you should be good to go.

These dotfiles on windows do assume that git is installed and git-bash is found at `c:/Program Files/Git/bin/bash.exe`.

### Updating

Getting the latest copy of these dotfiles is easy, because it's just a regular github repo. Run `git pull` and you should get all pushed changes, assuming no merge conflict or something.

## Documentation

Further documentation can be found within the [docs directory](/docs) in this repo. This includes information about specific tools, as well as more meta-level documentation like the design philosophy of this dotfiles management style.
