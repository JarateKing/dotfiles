# Philosophy

There's a few things I wanted out of a dotfiles repo:

1. To be managed with source control directly in the home directory. I did not want to have my dotfiles without any source control, or have actual dotfiles be in one place and attempt to replicate them under source control in a repo somewhere else, I didn't want to deal with the potential headache of symlinks, etc.
2. To not require any sort of tooling or significantly transformative steps to install. Convenience in the form of an install script is fine, but I wanted this install process to be very simple and totally viable to do manually.
3. To not be too strongly tied to any one specific distro.

For this reason, our dotfiles are mostly just stored as-is, with a repo directly in the home directory. This requires a few functional files in the home directory:

- a `readme.md` that also acts as an install script
- `.gitignore` to handle filtering files in/out of the repo, making managing dotfiles under source control much easier

As well as a few important subdirectories:

- a `docs` directory for documentation like this
- a `nix-shells` directory for `.nix` files that can be used to spin-up temporary nix workspaces
- a `scripts` directory for various different bash scripts

One concern was that this would mean every subdirectory in the home directory would also consider itself a part of the dotfiles repo when we run `git status`, but we were able to solve this by setting `GIT_CEILING_DIRECTORIES` and make it so that git only recognizes the dotfiles repo if our working directory is home, any subdirectories won't search the home directory for `.git`. To run git commands on this dotfiles repo, `cd ~` first.

All in all we end up with a fairly minimal setup that doesn't require much dependencies (namely, `git` itself to clone this repo, and even that's optional).
