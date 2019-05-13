###　locate/mlocate/slocate + web

https://github.com/ehoppmann/mlocate-web
https://github.com/WojciechMula/locatedb

### updatedb.conf
$ vim /etc/updatedb.conf
```
(-)#RUNE_BIND_MOUNTS = "yes"
(FS)#PRUNEFS = "9p afs anon_inodefs auto autofs bdev binfmt_misc cgroup cifs coda c>
(NAME)#PRUNENAMES = ".git .hg .svn"
(PATH)#PRUNEPATHS = "/afs /media /mnt /net /sfs /tmp /udev /var/cache /var/lib/pacman>
```

```
locate命令用于查找文件, 它比find命令的搜索速度快, 它需要一个数据库, 这个数据库由每天的例行工作

(crontab)程序来建立. 当们建立好这个数据库后, 就可以方便地来搜寻所需文件了. 即先运行updatedb

(无论在那个目录中均可, 可以放在crontab中)后在/var/lib/slocate/下生成slocate.db数据库即可快速查找.

在命令提示符下直接执行updatedb命令即可.

例如查找相关字issue:

$ locate issue

/etc/issue

/etc/issue.net

/usr/man/man5/issue.5

/usr/man/man5/issue.net.5

它默认没有扫描外接的移动硬盘或者挂载在/media下的其他分区. 以/etc/updatedb.conf文件为例, 内容如下:

-------------------------------------------------------------------------

PRUNE_BIND_MOUNTS="yes"

# PRUNENAMES=".git .bzr .hg .svn"

PRUNEPATHS="/tmp /var/spool /media"

PRUNEFS="NFS nfs nfs4 rpc_pipefs afs binfmt_misc proc smbfs autofs iso9660 ncpfs coda devpts ftpfs

devfs mfs shfs sysfs cifs lustre_lite tmpfs usbfs udf"

-------------------------------------------------------------------------

第一行PRUNE_BIND_MOUNTS="yes"的意思是: 是否进行限制搜索.

第二行 # PRUNENAMES=".git .bzr .hg .svn"表示对哪些后缀的文件排除检索, 也就是列在这里面的后缀的

文件跳过不进行检索. 不同后缀之间用空格隔开. 这个功能默认是关闭的(用#注释掉了), 如果需要打开需将

#去掉.

第三行是排除检索的路径, 即列出的路径下的文件和子文件夹均跳过不进行检索. 其中/media目录被屏蔽掉了.

第四行是排除检索的文件系统类型, 即列出的文件系统类型不进行检索.

只需要将第三行中的/meida删除即可. 修改为PRUNEPATHS="/tmp /var/spool ", 重新运行updatedb,

再进行locate即可以对原来挂载在/media下的windows ntfs分区进行搜索.
```
