# iptables v4
# iptables -L -v -n

iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

iptables -t nat -A PREROUTING -m limit --limit 5/min -j LOG --log-prefix "PRE-ALL "
iptables -t nat -A INPUT -i lo -j ACCEPT
iptables -t nat -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -t nat -A INPUT -p icmp -j ACCEPT
iptables -t nat -A INPUT -s 1.230.0.0/16 -p tcp -m tcp --dport 22 -j ACCEPT
iptables -t nat -A INPUT -s 1.230.0.0/16 -p tcp -m tcp --dport 3389 -j ACCEPT
iptables -t nat -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
iptables -t nat -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT
iptables -t nat -A INPUT -p tcp -m tcp --dport 25 -j ACCEPT
iptables -t nat -A INPUT -p tcp -m tcp --dport 587 -j ACCEPT
iptables -t nat -A INPUT -p tcp -m tcp --dport 993 -j ACCEPT
iptables -t nat -A INPUT -p tcp -m tcp --dport 995 -j ACCEPT
iptables -t nat -A INPUT -m state --state INVALID,NEW -j LOG --log-prefix "HACKER "
iptables -t nat -A OUTPUT -m limit --limit 5/min -j LOG --log-prefix "OUTPUT-ALL "

iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -p icmp -j ACCEPT
iptables -A INPUT -m conntrack --ctstate NEW -j LOG --log-prefix "NEW-CONN "
iptables -A INPUT -s 1.230.0.0/16 -p tcp -m tcp --dport 22 -j ACCEPT
iptables -A INPUT -s 1.230.0.0/16 -p tcp -m tcp --dport 3389 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 25 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 587 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 993 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 995 -j ACCEPT
iptables -A INPUT -m state --state INVALID,NEW -j LOG --log-prefix "HACKER-INP "
iptables -A INPUT -m state --state INVALID,NEW -j DROP
iptables -A INPUT -m limit --limit 5/min -j LOG --log-prefix "DROP " --log-level 7
iptables -A INPUT -j DROP
iptables -A FORWARD -j LOG --log-prefix "FORWARD-ALL "
iptables -A FORWARD -j DROP
iptables -A OUTPUT -m limit --limit 5/min -j LOG --log-prefix "OUTPUT-ALL "

# ip6tables v6
# iptables -t nat -L -v -n

ip6tables -F
ip6tables -X
ip6tables -t nat -F
ip6tables -t nat -X
ip6tables -t mangle -F
ip6tables -t mangle -X
ip6tables -t nat -P PREROUTING ACCEPT
ip6tables -t nat -P INPUT ACCEPT
ip6tables -t nat -P OUTPUT ACCEPT

ip6tables -t nat -A PREROUTING -m limit --limit 5/min -j LOG --log-prefix "PRE-ALL6 "
ip6tables -t nat -A INPUT -i lo -j ACCEPT
ip6tables -t nat -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
ip6tables -t nat -A INPUT -p icmp -j ACCEPT
ip6tables -t nat -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
ip6tables -t nat -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT
ip6tables -t nat -A INPUT -p tcp -m tcp --dport 25 -j ACCEPT
ip6tables -t nat -A INPUT -p tcp -m tcp --dport 587 -j ACCEPT
ip6tables -t nat -A INPUT -m state --state INVALID,NEW -j LOG --log-prefix "HACKER6 "
ip6tables -t nat -A OUTPUT -m limit --limit 5/min -j LOG --log-prefix "OUTPUT-ALL6 "

ip6tables -A INPUT -i lo -j ACCEPT
ip6tables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
ip6tables -A INPUT -p icmp -j ACCEPT
ip6tables -A INPUT -m conntrack --ctstate NEW -j LOG --log-prefix "NEW-CONN6 "
ip6tables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
ip6tables -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT
ip6tables -A INPUT -p tcp -m tcp --dport 25 -j ACCEPT
ip6tables -A INPUT -p tcp -m tcp --dport 587 -j ACCEPT
ip6tables -A INPUT -m state --state INVALID,NEW -j LOG --log-prefix "HACKER-INP6 "
ip6tables -A INPUT -m state --state INVALID,NEW -j DROP
ip6tables -A INPUT -m limit --limit 5/min -j LOG --log-prefix "DROP6 " --log-level 7
ip6tables -A INPUT -j DROP
ip6tables -A FORWARD -j LOG --log-prefix "FORWARD-ALL "
ip6tables -A FORWARD -j DROP
ip6tables -A OUTPUT -m limit --limit 5/min -j LOG --log-prefix "OUTPUT-ALL6 "

# show in log each new connection 
# grep "NEW-CONN" /var/log/kern.log | | wc -l

# show in log each new connection 
# grep "NEW-CONN6" /var/log/kern.log | | wc -l
