# .bash_profile

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc

# Scripts to start after logging on
$HOME/scripts/notify_login.sh 'supersecret@email.com' 'localhost' >/dev/null 2>&1 & disown -a

# Start xorg after logging in tty1
if [[ $(tty) = "/dev/tty1" ]]
then
  exec xinit i3
  exit 0
fi
