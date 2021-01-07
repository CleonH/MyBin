sshfs mount

```
#!/usr/bin/expect
set timeout 30
spawn  -ignore HUP sshfs user@shenzhen.liuwenwen.net:/ /home/ubuntu/Pictures/shenzhen/ -p 2424
expect "*password:"
send "mimamiamiazzaq!\r"
interact
```
