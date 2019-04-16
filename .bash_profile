# .bash_profile

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTFILE=$HOME/.bash_history
HISTSIZE=100000
#HISTFILESIZE=-1

export PATH="$PATH:$HOME/scripts:$HOME/bin:$HOME/.local/bin"
export EDITOR='/bin/vim -p'
export VISUAL='/bin/vim -p'

# Scripts to start after logging on
$HOME/scripts/notify_login.sh 'supersecret@email.com'>/dev/null 2>&1 & disown -a

# Start xorg after logging in tty1
if [[ $(tty) = "/dev/tty1" ]]
then
  exec xinit i3
  exit 0
fi
