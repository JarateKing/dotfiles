## Nix

curl -fsSL https://install.determinate.systems/nix | sh -s -- install
export PATH=~/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH

## Packages

nix profile add nixpkgs#git nixpkgs#emacs nixpkgs#neovim nixpkgs#ripgrep nixpkgs#alacritty nixpkgs#zellij nixpkgs#gitu

## Gnome configuration

### remap capslock to ctrl
gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"

### no mouse accel
gsettings set org.gnome.desktop.peripherals.mouse accel-profile "flat"

### show hidden files
gsettings set org.gtk.gtk4.Settings.FileChooser show-hidden "true"

### suppress bell noise
gsettings set org.gnome.Console audible-bell "false"
