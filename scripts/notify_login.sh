#!/usr/bin/env bash
# install s-nail + postfix + geoip
# insp: https://gist.github.com/tommybutler/6953743#file-iloggedin-sh

recipient=$1; shift
ignored_ips="$@"
ignored_ips+="$(seq -s $'\n192.168.0.' 0 255)"
remote_ip=$(echo $SSH_CLIENT | awk '{print $1}')
current_date=$(date +'%F %T')
msg_subject="Alert! $remote_ip - login to $(hostname)"

if [[ -z "$remote_ip" ]]; then
    remote_ip="localhost"
else
    ip_location="$(geoiplookup $remote_ip | grep -v 'not found' |
    awk -F ', ' '{print $NF;exit}')"
fi

if echo -e "$ignored_ips" | grep -q "$remote_ip" ; then
    exit 0
fi

msg_body="New login to ${USER}@$(hostname) from $remote_ip \
$([[ -n $ip_location ]] && echo "($ip_location) ")at $current_date"

echo -e "$msg_body" | mail -s "$msg_subject" "$recipient"
