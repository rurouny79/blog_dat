# parameter
TARGET=81

# win11: enable rdp
iptables -I INPUT -p tcp -s 0.0.0.0/0 -d 192.168.0.2 --dport 43389 -j ACCEPT
iptables -I FORWARD -m tcp -p tcp -d 192.168.122.$TARGET --dport 3389 -j ACCEPT
iptables -I FORWARD -m state -p tcp -d 192.168.0.0/24 --state NEW,RELATED,ESTABLISHED -j ACCEPT
iptables -t nat -I PREROUTING -p tcp -d 192.168.0.2 --dport 43389 -j DNAT --to-destination 192.168.122.$TARGET:3389

# ubuntu22.04: enable rdp
iptables -I INPUT -p tcp -s 0.0.0.0/0 -d 192.168.0.2 --dport 53389 -j ACCEPT
iptables -I FORWARD -m tcp -p tcp -d 192.168.122.223 --dport 3389 -j ACCEPT
iptables -I FORWARD -m state -p tcp -d 192.168.0.0/24 --state NEW,RELATED,ESTABLISHED -j ACCEPT
iptables -t nat -I PREROUTING -p tcp -d 192.168.0.2 --dport 53389 -j DNAT --to-destination 192.168.122.223:3389

# win11: enable sunshine
iptables -I INPUT -p tcp -s 0.0.0.0/0 -d 192.168.0.2 --dport 47984 -j ACCEPT
iptables -I INPUT -p udp -s 0.0.0.0/0 -d 192.168.0.2 --dport 47989 -j ACCEPT
iptables -I INPUT -p udp -s 0.0.0.0/0 -d 192.168.0.2 --dport 47998 -j ACCEPT
iptables -I INPUT -p udp -s 0.0.0.0/0 -d 192.168.0.2 --dport 47999 -j ACCEPT
iptables -I INPUT -p udp -s 0.0.0.0/0 -d 192.168.0.2 --dport 48000 -j ACCEPT
iptables -I INPUT -p udp -s 0.0.0.0/0 -d 192.168.0.2 --dport 48002 -j ACCEPT
iptables -I INPUT -p tcp -s 0.0.0.0/0 -d 192.168.0.2 --dport 48010 -j ACCEPT
iptables -I INPUT -p udp -s 0.0.0.0/0 -d 192.168.0.2 --dport 48010 -j ACCEPT


iptables -I FORWARD -m tcp -p tcp -d 192.168.122.$TARGET --dport 47984 -j ACCEPT
iptables -I FORWARD -m tcp -p tcp -d 192.168.122.$TARGET --dport 47989 -j ACCEPT
iptables -I FORWARD -m udp -p udp -d 192.168.122.$TARGET --dport 47998 -j ACCEPT
iptables -I FORWARD -m udp -p udp -d 192.168.122.$TARGET --dport 47999 -j ACCEPT
iptables -I FORWARD -m udp -p udp -d 192.168.122.$TARGET --dport 48000 -j ACCEPT
iptables -I FORWARD -m udp -p udp -d 192.168.122.$TARGET --dport 48002 -j ACCEPT
iptables -I FORWARD -m tcp -p tcp -d 192.168.122.$TARGET --dport 48010 -j ACCEPT
iptables -I FORWARD -m udp -p udp -d 192.168.122.$TARGET --dport 48010 -j ACCEPT


iptables -I FORWARD -m state -p tcp -d 192.168.0.0/24 --state NEW,RELATED,ESTABLISHED -j ACCEPT
iptables -I FORWARD -m state -p udp -d 192.168.0.0/24 --state NEW,RELATED,ESTABLISHED -j ACCEPT


iptables -t nat -I PREROUTING -p tcp -d 192.168.0.2 --dport 47984 -j DNAT --to-destination 192.168.122.$TARGET:47984
iptables -t nat -I PREROUTING -p tcp -d 192.168.0.2 --dport 47989 -j DNAT --to-destination 192.168.122.$TARGET:47989
iptables -t nat -I PREROUTING -p udp -d 192.168.0.2 --dport 47998 -j DNAT --to-destination 192.168.122.$TARGET:47998
iptables -t nat -I PREROUTING -p udp -d 192.168.0.2 --dport 47999 -j DNAT --to-destination 192.168.122.$TARGET:47999
iptables -t nat -I PREROUTING -p udp -d 192.168.0.2 --dport 48000 -j DNAT --to-destination 192.168.122.$TARGET:48000
iptables -t nat -I PREROUTING -p udp -d 192.168.0.2 --dport 48002 -j DNAT --to-destination 192.168.122.$TARGET:48002
iptables -t nat -I PREROUTING -p tcp -d 192.168.0.2 --dport 48010 -j DNAT --to-destination 192.168.122.$TARGET:48010
iptables -t nat -I PREROUTING -p udp -d 192.168.0.2 --dport 48010 -j DNAT --to-destination 192.168.122.$TARGET:48010
