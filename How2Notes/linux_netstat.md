
### watch port
```
sudo netstat -apn |grep dnsmasq
```

### net speed
```
#speed of device/interface     
$ iftop/jnettop/nload/ntop
#speed of application/process  
$ nethogs
```

### dns-server  /etc/resolv.conf

- /etc/resolvconf.conf  
```
## self-defind dns-server
$ resolvconf -u
```

- wpa_wireless setting
```
DHCP-auto
DHCP-auto-IPonly
```

- /etc/dnsmasq.conf
```
## using local stubby DNS-over-TLS
no-resolv
proxy-dnssec
server=::1#53000
server=127.0.0.1#53000
listen-address=::1,127.0.0.1
## dnsmasq-china-list
...

```
