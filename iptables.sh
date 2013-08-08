#!/bin/bash
IPT=/sbin/iptables
echo "Stopping firewall and allowing everyone..."
$IPT -F
$IPT -X
$IPT -t nat -F
$IPT -t nat -X
$IPT -t mangle -F
$IPT -t mangle -X
$IPT -P INPUT ACCEPT
$IPT -P FORWARD ACCEPT
$IPT -P OUTPUT ACCEPT

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


$IPT -A INPUT -p tcp -m multiport --dports 80,443 -m string --string ${URL} --algo kmp -m state --state NEW -m recent --set
$IPT -A INPUT -p tcp -m multiport --dports 80,443 -m string --string ${URL} --algo kmp -m state --state NEW -m recent --update --seconds ${SECONDS} --hitcount ${BLOCKCOUNT} -j ${DACTION}

# Тестовое правило для полного запрета подключений с заданной маской
# $IPT -A INPUT -p tcp -m multiport --dports 80,443 -m string --string ${URL} --algo kmp -m state --state NEW -j DROP

# Тестовые правила аналогичные включенынм, но действующие НЕ только на новые подключения
#$IPT -A INPUT -p tcp -m multiport --dports 80,443 -m string --string ${URL} --algo kmp -m recent --set
#$IPT -A INPUT -p tcp -m multiport --dports 80,443 -m string --string ${URL} --algo kmp -m recent --update --seconds ${SECONDS} --hitcount ${BLOCKCOUNT} -j ${DACTION}
