## boot

### systemd
- https://linux.cn/article-10301-1.html
- https://linuxtoy.org/archives/systemd-journal.html

### rc.local / crontab / @reboot
arch-wiki crontab
```
pacman -Ss cronie

```
crontab folder 
```
(root) /etc/crontab
(user) /var/spool/cron/$USERNAME    ## modify by crontab -e 
(cronie)/etc/cron.d
(add tmp)/etc/cron.d/tmpcronfile
```
crontab -e SAMPLE
```
* * * * * touch /tmp/crontab-workingtest.log
@reboot date >> /tmp/crontab-reboot-time.log
```


## reboot
```
$ cat /usr/bin/reboot
sudo systemctl stop SERVICE@USER
/usr/bin/reboot-cli
```



## X-server

### xprofile / xinit / xsession /  
```### input fcitx/ibus
export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
```

### Xmodmap / xmodmaprc / 
- xfce-superkey
- remap-capslock
