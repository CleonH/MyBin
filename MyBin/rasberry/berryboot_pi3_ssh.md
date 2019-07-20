edit /sdb2/data/shared/etc/rc.local

[/media/pi/berryboot/shared/etc$]
```
sudo update-rc.d ssh enable
sudo systemctl start sshd
```
```
pi@raspberrypi:~$ df -h
Filesystem      Size  Used Avail Use% Mounted on
dev             412M     0  412M   0% /dev
none             15G   11G  3.1G  78% /
tmpfs           421M     0  421M   0% /dev/shm
tmpfs           421M   22M  400M   6% /run
tmpfs           5.0M  4.0K  5.0M   1% /run/lock
tmpfs           421M     0  421M   0% /sys/fs/cgroup
tmpfs            85M     0   85M   0% /run/user/1000
/dev/mmcblk0p2   15G   11G  3.1G  78% /media/pi/berryboot
/dev/mmcblk0p1  127M   42M   85M  34% /media/pi/boot
pi@raspberrypi:~$ cd /media/pi/berryboot
pi@raspberrypi:/media/pi/berryboot$ ls
data  images  lost+found  shared  tmp
pi@raspberrypi:/media/pi/berryboot$ cd shared
pi@raspberrypi:/media/pi/berryboot/shared$ ls
etc  lib
pi@raspberrypi:/media/pi/berryboot/shared$ cd etc
pi@raspberrypi:/media/pi/berryboot/shared/etc$ ls
default  network  rc.local  resolv.conf  timezone
pi@raspberrypi:/media/pi/berryboot/shared/etc$ cat rc.local
sudo update-rc.d ssh enable
sudo systemctl restart sshd
```
