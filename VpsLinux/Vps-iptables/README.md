# Linux iptables firewall

### Aktywne reguły firewalla ipv4 lub ipv6 (iptables lub ip6tables)
iptables -L -v -n , ip6tables -L -v -n
# lub dla konkretnej tablicy (raw)
iptables -t nat -L -n -v


### Polityka na przyjmuj wszystkie połączenia ACCEPT lub blokuj DROP
```
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
```

### Wyczyść wszystkie reguły
```
# tablica filter
iptables -F
iptables -X
# tablica raw
iptables -t nat -F
iptables -t nat -X
# tablica mangle
iptables -t mangle -F
iptables -t mangle -X
```

### Pozwolenie na ruch wewnętrzny localhost na vps
```
# tablica filter
iptables -A INPUT -i lo -j ACCEPT
# dla innej tablicy (raw)
# iptables -t nat -A INPUT -i lo -j ACCEPT
```

### Przepuszczaj połączenia zainicjowane przez nasz server (wychodzące)
```
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
```

### Zapisuj wszystko do logów
```
iptables -A INPUT -m limit --limit 5/min -j LOG --log-prefix "ALL-INPUT "
```

### Zapisuj do logów nowe połączenia
```
iptables -A INPUT -m conntrack --ctstate NEW -j LOG --log-prefix "NEW-CONN "
```

### Pozwól na pingi
```
iptables -A INPUT -p icmp -j ACCEPT
```

### Odrzucaj błędne połączenia
```
iptables -A INPUT -m state --state INVALID,NEW -j LOG --log-prefix "HACKER-INP "
iptables -A INPUT -m state --state INVALID,NEW -j DROP
```

### Pozwól na połączenia do ssh i rdp, xrdp z określonej podsieci /8, /16, /24
```
iptables -A INPUT -s 1.2.0.0/16 -p tcp -m tcp --dport 22 -j ACCEPT
iptables -A INPUT -s 1.2.0.0/16 -p tcp -m tcp --dport 3389 -j ACCEPT
```

### Otwórz porty dla usług
```
# http, https, apache2, nginx
iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT
# smtp, postfix
iptables -A INPUT -p tcp -m tcp --dport 25 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 587 -j ACCEPT
# imap, pop, ssl, dovecot
iptables -A INPUT -p tcp -m tcp --dport 993 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 995 -j ACCEPT
```

### Loguj i odrzucaj wszystko inne na wejściu i przekazywaniu, pozwól na wszystko na wyjściu
```
# wejściowe
iptables -A INPUT -m limit --limit 5/min -j LOG --log-prefix "DROP " --log-level 7
iptables -A INPUT -j DROP
# przekazywane
iptables -A FORWARD -j LOG --log-prefix "FORWARD-ALL "
iptables -A FORWARD -j DROP
# pozwól na wszystkie wychodzące tylko zapisuj do logów
iptables -A OUTPUT -m limit --limit 5/min -j LOG --log-prefix "OUTPUT-ALL "
```

### Zapisz reguły do pliku
```
iptables-save > ip4
ip6tables-save > ip6
```

### Wszytaj reguły
```
iptables-restore < ip4
ip6tables-restore < ip6
```

### firewall start on reboot
```
# zainstaluj po dodaniu wszystkich reguł do firewalla
apt-get install iptables-persistent
```
