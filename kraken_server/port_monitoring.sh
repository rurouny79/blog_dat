#!/bin/sh

tcpdump "tcp[tcpflags] & (tcp-syn) != 0" -l -n -i enp7s0 and inbound and dst port '(445 or 443 or 139 or 80 or 22 or 3389)' or "tcp[tcpflags] & (tcp-syn) != 0" -l -n -i enp7s0 and inbound and dst portrange '(1001-1004 or 2001-2003 or 3001-3003 or 3389)'| while read line; do
{
echo To: criny.master@gmail.com
echo Subject: kraken port warning
echo
echo $line
} | ssmtp criny.master@gmail.com
done
