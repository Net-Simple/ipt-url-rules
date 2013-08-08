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