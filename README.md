# My dotfiles

## Summary:

this is a mess x3

## Notes:

### i3
My i3 config has gotten very long, I put it here so I can check its history if I end up breaking something in the future. I make an effort to document most things somewhat.

There's a few scripts (found in `scripts`) it relies on, the most important being `i3_reload.sh` to start polybar/dunst/redshift/copyq and scratchpads.

### Xresources
Used to configure URxvt, which has a few extensions that use CTRL+ALT bindings (I use kitty now tho).

### polybar
Has modules that rely on `scripts`. Remove the `[updates-void]` module if you are not using Void Linux.

### compton
My `compton.conf` has lots lines that were copied from [here](https://github.com/oddlyspaced/dotfiles/blob/dracula-arch/.config/compton.conf).
