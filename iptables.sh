#!/bin/bash
IPT=/sbin/iptables
echo "Stopping firewall and allowing everyone..."
IPT -F
IPT -X
IPT -t nat -F
IPT -t nat -X
IPT -t mangle -F
IPT -t mangle -X
IPT -P INPUT ACCEPT
IPT -P FORWARD ACCEPT
IPT -P OUTPUT ACCEPT

# Max connection in seconds
SECONDS=1
# Max connections per IP
BLOCKCOUNT=2
# URL 
URL="/v1/users/login"
URL1="/v/users/login"
# ....
# ..
# default action can be DROP or REJECT
DACTION="DROP"


$IPT -A INPUT -m string --string ${URL} --algo kmp --to 65535 -m state --state NEW -m recent --set
$IPT -A INPUT -m string --string ${URL} --algo kmp --to 65535 -m state --state NEW -m recent --update --seconds ${SECONDS} --hitcount ${BLOCKCOUNT} -j ${DACTION}

$IPT -A INPUT -m string --string ${URL1} --algo kmp --to 65535 -m state --state NEW -m recent --set
$IPT -A INPUT -m string --string ${URL1} --algo kmp --to 65535 -m state --state NEW -m recent --update --seconds ${SECONDS} --hitcount ${BLOCKCOUNT} -j ${DACTION}