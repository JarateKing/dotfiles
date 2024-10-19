## Gnome configuration

### remap capslock to ctrl
gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"

### no mouse accel
gsettings set org.gnome.desktop.peripherals.mouse accel-profile "flat"

### show hidden files
gsettings set org.gtk.gtk4.Settings.FileChooser show-hidden "true"
