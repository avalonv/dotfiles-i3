# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
#HISTFILESIZE=-1

export PATH="$PATH:$HOME/scripts:$HOME/bin:$HOME/.local/bin"
export EDITOR='/bin/vim -p'
export VISUAL='/bin/vim -p'

function set_prompt
{
    local last_exit=$?
    local cool_ass_cat='~(=^⋅ω⋅^)'
    local PS1begin='\[\e[m\]|\[\e[1;30m\]'
    local PS1user='\[\e[1;31m\]\u\[\e[m\]'
    local PS1host='\[\e[m\]@\h'
    local PS1bad='|\[\e[1;32m\]'"${last_exit}"
    local PS1time='(\A)'
    local PS1dir='\[\e[m\]|\[\e[1;34m\]\w\[\e[m\]'
    local PS1end='\n\[\e[1;37m\]\$\[\e[m\] '

    if [[ $(pwd) == "/home/$(id -nu ${UID})" ]]; then
      PS1dir="\[\e[m\]|\[\e[1;33m\]$cool_ass_cat\[\e[m\]"
    fi

    if [[ $last_exit = 0 ]]; then
        PS1="${PS1begin}${PS1user}${PS1host}${PS1dir} ${PS1time}${PS1end}"
    else
        PS1="${PS1begin}${PS1user}${PS1host}${PS1bad}${PS1dir} ${PS1time}${PS1end}"
    fi
}

function copyq_copy
{
   local this="$@"

   copyq copy "$this"
}


function dict_query
{ # colorit is part of the "m4" package
   local term="$@"

   dict -i wn "$term" | colorit | tail --lines=+50
}


PROMPT_COMMAND='set_prompt'

# void only
alias xbps-update='xbps-install -Su'
alias xbps-search='xbps-query --regex -Rs'
alias xbps-info='xbps-query -RS'
alias xbps-deps='xbps-query -Rx'
alias xbps-install='xbps-install -S'

# My scripts
alias gowifi='sudo sv reload wpa_supplicant'
alias goeth='sudo $HOME/scripts/connect_ethernet.sh'
alias scanip='$HOME/scripts/pingsweep.sh'
alias vore='$HOME/scripts/vore.sh'
alias man='$HOME/scripts/vore.sh'
alias kyll='$HOME/scripts/kyll.sh'

alias vim='vim -p'
alias copy='copyq_copy'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias ls='ls --color=auto '
alias ll='ls --color=auto -lah'
alias la='ls --color=auto -a'
alias l='ls --color=auto -CF'
alias lm='ls --color=auto -ltcAh'
alias lh='ls --color=auto --human-readable -sAh'
alias sudo='sudo '

alias screenoff='xset dpms force suspend'
alias standby='sudo xbacklight -set 2 && sleep 4 && xset dpms force standby'
alias lock='xscreensaver-command -lock'
alias killjobs='kill $(jobs -p)'
alias snow='for((I=0;J=--I;))do clear;for((D=LINES;S=++J**3%COLUMNS,--D;))do printf %*s*\\n $S;done;sleep .1;done'
alias dic='dict_query'
alias do_bonsai='while true; do ~/gitlab/bonsai.sh/bonsai.sh -l -t 1.0 -T -L 32 -b 2 && notify-send "bonsai $(echo $tty)" && sleep 1m; done'
alias term_colors='for code in {0..255}; do echo -e "\e[38;05;${code}m $code: Test"; done' # https://stackoverflow.com/a/28938235/8225672 # https://stackoverflow.com/questions/6403744/are-there-terminals-that-support-true-color#comment24567873_6486000
