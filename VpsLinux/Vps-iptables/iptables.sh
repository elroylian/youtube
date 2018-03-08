# backup and restore iptables

# install iptables
apt-get install iptables

# Show active rules
iptables -L -v -n

# Backup
iptables-save > ip4
ip6tables-save > ip6

# Restore
iptables-resore < ip4
ip6tables-resore < ip6

# Save iptables after change for reboot autoload
apt-get install iptables-persistent

# Clear all iptables rules ip4
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

# Clear all iptables rules ip6
ip6tables -F
ip6tables -X
ip6tables -t nat -F
ip6tables -t nat -X
ip6tables -t mangle -F
ip6tables -t mangle -X
ip6tables -t nat -P PREROUTING ACCEPT
ip6tables -t nat -P INPUT ACCEPT
ip6tables -t nat -P OUTPUT ACCEPT

