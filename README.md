# My dotfiles

## Notes:

### i3
My i3 config has gotten very long, I put it here so I can check its history if I end up breaking something in the future, but its not particularly well documented.

It doesn't use (m)any default bindings, and it has one or two options that require i3-gaps, but is otherwise not i3-gaps specific and doesn't include a gaps mode. There's also a few (very bad) scripts it relies on, the most important being `i3_reload.sh` to start polybar/dunst/redshift/copyq and scratchpads.

### Xresources
Used to configure URxvt, which has a few extensions that use CTRL+ALT bindings. Please don't laugh at my colorscheme.

### polybar
Remove the `[updates-void]` module if you are not using Void Linux.

### ranger
`rifle.conf` is configured to launch text files and files open using the `editor` label in a new terminal, but for some reason that doesn't always happen. If you find out why please tell me.

### rofi
Really tacky colorscheme. Most of the non comestic options are set in the i3 config.

### compton
My `compton.conf` has lots lines that were copied from [here](https://github.com/oddlyspaced/dotfiles/blob/dracula-arch/.config/compton.conf).
