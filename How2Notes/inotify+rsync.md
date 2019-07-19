1.  [专栏](/blogs)
2.  [Sean's Notes](/blog/seanlook)
3.  文章详情

# [Linux 下同步工具 inotify+rsync 使用详解](/a/1190000002427568)

- [inotify](/t/inotify/blogs)
- [rsync](/t/rsync/blogs)
- [linux](/t/linux/blogs)

37.4k 次阅读  ·  读完需要 36 分钟

8

# 1\. rsync

## 1.1 什么是 rsync

rsync 是一个远程数据同步工具，可通过 LAN/WAN 快速同步多台主机间的文件。它使用所谓的“Rsync 演算法”来使本地和远程两个主机之间的文件达到同步，这个算法只传送两个文件的不同部分，而不是每次都整份传送，因此速度相当快。所以通常可以作为备份工具来使用。

运行 Rsync server 的机器也叫 backup server，一个 Rsync server 可同时备份多个 client 的数据；也可以多个 Rsync server 备份一个 client 的数据。Rsync 可以搭配 ssh 甚至使用 daemon 模式。Rsync server 会打开一个 873 的服务通道(port)，等待对方 rsync 连接。连接时，Rsync server 会检查口令是否相符，若通过口令查核，则可以开始进行文件传输。第一次连通完成时，会把整份文件传输一次，下一次就只传送二个文件之间不同的部份。

**基本特点：**

1.  可以镜像保存整个目录树和文件系统；
2.  可以很容易做到保持原来文件的权限、时间、软硬链接等；
3.  无须特殊权限即可安装；
4.  优化的流程，文件传输效率高；
5.  可以使用 rcp、ssh 等方式来传输文件，当然也可以通过直接的 socket 连接；
6.  支持匿名传输。

**命令语法：**  
rsync 的命令格式可以为以下六种：  
　 rsync \[OPTION\]… SRC DEST  
　 rsync \[OPTION\]… SRC \[USER@\]HOST:DEST  
　 rsync \[OPTION\]… \[USER@\]HOST:SRC DEST  
　 rsync \[OPTION\]… \[USER@\]HOST::SRC DEST  
　 rsync \[OPTION\]… SRC \[USER@\]HOST::DEST  
　 rsync \[OPTION\]… rsync://\[USER@\]HOST\[:PORT\]/SRC \[DEST\]

对应于以上六种命令格式，我们可以总结 rsync 有 2 种不同的工作模式：

- shell 模式：使用远程 shell 程序（如 ssh 或 rsh）进行连接。当源路径或目的路径的主机名后面包含一个冒号分隔符时使用这种模式，rsync 安装完成后就可以直接使用了，无所谓启动。（目前没有尝试过这个方法）
- daemon 模式：使用 TCP 直接连接 rsync daemon。当源路径或目的路径的主机名后面包含两个冒号，或使用 rsync://URL 时使用这种模式，无需远程 shell，但必须在一台机器上启动 rsync daemon，默认端口 873，这里可以通过`rsync --daemon`使用独立进程的方式，或者通过 xinetd 超级进程来管理 rsync 后台进程。

当 rsync 作为 daemon 运行时，它需要一个用户身份。如果你希望启用 chroot，则必须以 root 的身份来运行 daemon，监听端口，或设定文件属主；如果不启用 chroot，也可以不使用 root 用户来运行 daemon，但该用户必须对相应的模块拥有读写数据、日志和 lock file 的权限。当 rsync 以 daemon 模式运行时，它还需要一个配置文件——rsyncd.conf。修改这个配置后不必重启 rsync daemon，因为每一次的 client 连接都会去重新读取该文件。

我们一般把 DEST 远程服务器端成为 rsync Server，运行 rsync 命令的一端 SRC 称为 Client。

**安装：**  
rsync 在 CentOS6 上默认已经安装，如果没有则可以使用`yum install rsync -y`，服务端和客户端是同一个安装包。

    # rsync -h

## 1.2 同步测试

关于`rsync`命令的诸多选项说明，见另外一篇文章[rsync 与 inotifywait 命令和配置选项说明](http://seanlook.com/2014/12/13/rsync_inotify_configuration)。

### 1.2.1 本机文件夹同步

    # rsync -auvrtzopgP --progress  /root/ /tmp/rsync_bak/

会看到从`/root/`传输文件到`/tmp/rsync_bak/`的列表和速率，再运行一次会看到 sending incremental file list 下没有复制的内容，可以在/root/下`touch`某一个文件再运行看到只同步了修改过的文件。

上面需要考虑以下问题：

- 删除/root/下的文件不会同步删除/tmp/rsync_bak，除非加入`--delete`选项
- 文件访问时间等属性、读写等权限、文件内容等有任何变动，都会被认为修改
- 目标目录下如果文件比源目录还新，则不会同步
- 源路径的最后是否有斜杠有不同的含义：有斜杠，只是复制目录中的文件；没有斜杠的话，不但要复制目录中的文件，还要复制目录本身

## 1.3 同步到远程服务器

在服务器间 rsync 传输文件，需要有一个是开着 rsync 的服务，而这一服务需要两个配置文件，说明当前运行的用户名和用户组，这个用户名和用户组在改变文件权限和相关内容的时候有用，否则有时候会出现提示权限问题。配置文件也说明了模块、模块化管理服务的安全性，每个模块的名称都是自己定义的，可以添加用户名密码验证，也可以验证 IP，设置目录是否可写等，不同模块用于同步不同需求的目录。

### 1.3.1 服务端配置文件

\*\* /etc/rsyncd.conf： \*\*

    #2014-12-11 by Sean
    uid=root
    gid=root
    use chroot=no
    max connections=10
    timeout=600
    strict modes=yes
    port=873
    pid file=/var/run/rsyncd.pid
    lock file=/var/run/rsyncd.lock
    log file=/var/log/rsyncd.log

    [module_test]
    path=/tmp/rsync_bak2
    comment=rsync test logs
    auth users=sean
    uid=sean
    gid=sean
    secrets file=/etc/rsyncd.secrets
    read only=no
    list=no
    hosts allow=172.29.88.204
    hosts deny=0.0.0.0/32

这里配置 socket 方式传输文件，端口 873，\[module_test\]开始定义一个模块，指定要同步的目录（接收）path，授权用户，密码文件，允许哪台服务器 IP 同步（发送）等。关于配置文件中选项的详细说明依然参考[rsync 与 inotifywait 命令和配置选项说明](http://seanlook.com/2014/12/13/rsync_inotify_configuration)。

经测试，上述配置文件每行后面不能使用`#`来来注释

\*\* /etc/rsyncd.secrets： \*\*

    sean:passw0rd

一行一个用户，用户名:密码。请注意这里的用户名和密码与操作系统的用户名密码无关，可以随意指定，与`/etc/rsyncd.conf`中的`auth users`对应。

修改权限：`chmod 600 /etc/rsyncd.d/rsync_server.pwd`。

### 1.3.2 服务器启动 rsync 后台服务

修改`/etc/xinetd.d/rsync`文件，disable 改为 no

    # default: off
    # description: The rsync server is a good addition to an ftp server, as it \
    #   allows crc checksumming etc.
    service rsync
    {
        disable = no
        flags       = IPv6
        socket_type     = stream
        wait            = no
        user            = root
        server          = /usr/bin/rsync
        server_args     = --daemon
        log_on_failure  += USERID
    }

执行`service xinetd restart`会一起重启 rsync 后台进程，默认使用配置文件`/etc/rsyncd.conf`。也可以使用`/usr/bin/rsync --daemon --config=/etc/rsyncd.conf`。

为了以防 rsync 写入过多的无用日志到`/var/log/message`（容易塞满从而错过重要的信息），建议注释掉`/etc/xinetd.conf`的 success：

    # log_on_success  = PID HOST DURATION EXIT

如果使用了防火墙，要添加允许 IP 到 873 端口的规则。

    # iptables -A INPUT -p tcp -m state --state NEW  -m tcp --dport 873 -j ACCEPT
    # iptables -L  查看一下防火墙是不是打开了 873端口
    # netstat -anp|grep 873

建议关闭`selinux`，可能会由于强访问控制导致同步报错。

### 1.3.3 客户端测试同步

单向同步时，客户端只需要一个包含密码的文件。  
**/etc/rsync_client.pwd：**

    passw0rd

chmod 600 /etc/rsync_client.pwd

**命令：**  
将本地`/root/`目录同步到远程 172.29.88.223 的/tmp/rsync_bak2 目录（module_test 指定）：

    /usr/bin/rsync -auvrtzopgP --progress --password-file=/etc/rsync_client.pwd /root/ sean@172.29.88.223::module_test

当然你也可以将远程的/tmp/rsync_bak2 目录同步到本地目录/root/tmp：

    /usr/bin/rsync -auvrtzopgP --progress --password-file=/etc/rsync_client.pwd sean@172.29.88.223::module_test /root/

从上面两个命令可以看到，其实这里的服务器与客户端的概念是很模糊的，rsync daemon 都运行在远程 172.29.88.223 上，第一条命令是本地主动推送目录到远程，远程服务器是用来备份的；第二条命令是本地主动向远程索取文件，本地服务器用来备份，也可以认为是本地服务器恢复的一个过程。

## 1.4 rsync 不足

与传统的 cp、tar 备份方式相比，rsync 具有安全性高、备份迅速、支持增量备份等优点，通过 rsync 可以解决对实时性要求不高的数据备份需求，例如定期的备份文件服务器数据到远端服务器，对本地磁盘定期做数据镜像等。

随着应用系统规模的不断扩大，对数据的安全性和可靠性也提出的更好的要求，rsync 在高端业务系统中也逐渐暴露出了很多不足，首先，rsync 同步数据时，需要扫描所有文件后进行比对，进行差量传输。如果文件数量达到了百万甚至千万量级，扫描所有文件将是非常耗时的。而且正在发生变化的往往是其中很少的一部分，这是非常低效的方式。其次，rsync 不能实时的去监测、同步数据，虽然它可以通过 crontab 方式进行触发同步，但是两次触发动作一定会有时间差，这样就导致了服务端和客户端数据可能出现不一致，无法在应用故障时完全的恢复数据。基于以上原因，rsync+inotify 组合出现了！

# 2\. inotify-tools

## 2.1 什么是 inotify

inotify 是一种强大的、细粒度的、异步的文件系统事件监控机制，Linux 内核从 2.6.13 开始引入，允许监控程序打开一个独立文件描述符，并针对事件集监控一个或者多个文件，例如打开、关闭、移动/重命名、删除、创建或者改变属性。

CentOS6 自然已经支持：  
使用`ll /proc/sys/fs/inotify`命令，是否有以下三条信息输出，如果没有表示不支持。

    total 0
    -rw-r--r-- 1 root root 0 Dec 11 15:23 max_queued_events
    -rw-r--r-- 1 root root 0 Dec 11 15:23 max_user_instances
    -rw-r--r-- 1 root root 0 Dec 11 15:23 max_user_watches

- `/proc/sys/fs/inotify/max_queued_evnets`表示调用 inotify_init 时分配给 inotify instance 中可排队的 event 的数目的最大值，超出这个值的事件被丢弃，但会触发 IN_Q_OVERFLOW 事件。
- `/proc/sys/fs/inotify/max_user_instances`表示每一个 real user ID 可创建的 inotify instatnces 的数量上限。
- `/proc/sys/fs/inotify/max_user_watches`表示每个 inotify instatnces 可监控的最大目录数量。如果监控的文件数目巨大，需要根据情况，适当增加此值的大小。

**inotify-tools：**

inotify-tools 是为 linux 下 inotify 文件监控工具提供的一套 C 的开发接口库函数，同时还提供了一系列的命令行工具，这些工具可以用来监控文件系统的事件。 inotify-tools 是用 c 编写的，除了要求内核支持 inotify 外，不依赖于其他。inotify-tools 提供两种工具，一是`inotifywait`，它是用来监控文件或目录的变化，二是`inotifywatch`，它是用来统计文件系统访问的次数。

下载 inotify-tools-3.14-1.el6.x86_64.rpm，通过 rpm 包安装：

    # rpm -ivh /apps/crm/soft_src/inotify-tools-3.14-1.el6.x86_64.rpm
    warning: /apps/crm/soft_src/inotify-tools-3.14-1.el6.x86_64.rpm: Header V3 DSA/SHA1 Signature, key ID 4026433f: NOKEY
    Preparing...                ########################################### [100%]
       1:inotify-tools          ########################################### [100%]
    # rpm -qa|grep inotify
    inotify-tools-3.14-1.el5.x86_64

## 2.2 inotifywait 使用示例

监控/root/tmp 目录文件的变化：

    /usr/bin/inotifywait -mrq --timefmt '%Y/%m/%d-%H:%M:%S' --format '%T %w %f' \
     -e modify,delete,create,move,attrib /root/tmp/

上面的命令表示，持续监听`/root/tmp`目录及其子目录的文件变化，监听事件包括文件被修改、删除、创建、移动、属性更改，显示到屏幕。执行完上面的命令后，在`/root/tmp`下创建或修改文件都会有信息输出：

    2014/12/11-15:40:04 /root/tmp/ new.txt
    2014/12/11-15:40:22 /root/tmp/ .new.txt.swp
    2014/12/11-15:40:22 /root/tmp/ .new.txt.swx
    2014/12/11-15:40:22 /root/tmp/ .new.txt.swx
    2014/12/11-15:40:22 /root/tmp/ .new.txt.swp
    2014/12/11-15:40:22 /root/tmp/ .new.txt.swp
    2014/12/11-15:40:23 /root/tmp/ .new.txt.swp
    2014/12/11-15:40:31 /root/tmp/ .new.txt.swp
    2014/12/11-15:40:32 /root/tmp/ 4913
    2014/12/11-15:40:32 /root/tmp/ 4913
    2014/12/11-15:40:32 /root/tmp/ 4913
    2014/12/11-15:40:32 /root/tmp/ new.txt
    2014/12/11-15:40:32 /root/tmp/ new.txt~
    2014/12/11-15:40:32 /root/tmp/ new.txt
    ...

# 3\. rsync 组合 inotify-tools 完成实时同步

这一步的核心其实就是在客户端创建一个脚本`rsync.sh`，适用`inotifywait`监控本地目录的变化，触发`rsync`将变化的文件传输到远程备份服务器上。为了更接近实战，我们要求一部分子目录不同步，如`/root/tmp/log`和临时文件。

## 3.1 创建排除在外不同步的文件列表

排除不需要同步的文件或目录有两种做法，第一种是 inotify 监控整个目录，在 rsync 中加入排除选项，简单；第二种是 inotify 排除部分不监控的目录，同时 rsync 中也要加入排除选项，可以减少不必要的网络带宽和 CPU 消耗。我们选择第二种。

### 3.1.1 inotifywait 排除

这个操作在客户端进行，假设`/tmp/src/mail/2014/`以及`/tmp/src/mail/2015/cache/`目录下的所有文件不用同步，所以不需要监控，`/tmp/src/`下的其他文件和目录都同步。（其实对于打开的临时文件，可以不监听`modify`时间而改成监听`close_write`）

inotifywait 排除监控目录有`--exclude <pattern>`和`--fromfile <file>`两种格式，并且可以同时使用，但主要前者可以用正则，而后者只能是具体的目录或文件。

    # vi /etc/inotify_exclude.lst：
    /tmp/src/pdf
    @/tmp/src/2014

使用`fromfile`格式只能用绝对路径，不能使用诸如`*`正则表达式去匹配，`@`表示排除。

如果要排除的格式比较复杂，必须使用正则，那只能在`inotifywait`中加入选项，如`--exclude '(.*/*\.log|.*/*\.swp)$|^/tmp/src/mail/(2014|201.*/cache.*)'`，表示排除/tmp/src/mail/以下的 2014 目录，和所有 201\*目录下的带 cache 的文件或目录，以及/tmp/src 目录下所有的以.log 或.swp 结尾的文件。

### 3.1.2 rsync 排除

使用 inotifywait 排除监控目录的情况下，必须同时使用 rsync 排除对应的目录，否则只要有触发同步操作，必然会导致不该同步的目录也会同步。与 inotifywait 类似，rsync 的同步也有`--exclude`和`--exclude-from`两种写法。

个人还是习惯将要排除同步的目录卸载单独的文件列表里，便于管理。使用`--include-from=FILE`时，排除文件列表用绝对路径，但 FILE 里面的内容请用相对路径，如：  
`/etc/rsyncd.d/rsync_exclude.lst`：

    mail/2014/
    mail/201*/201*/201*/.??*
    mail??*
    src/*.html*
    src/js/
    src/ext3/
    src/2014/20140[1-9]/
    src/201*/201*/201*/.??*
    membermail/
    membermail??*
    membermail/201*/201*/201*/.??*

排除同步的内容包括，mail 下的 2014 目录，类似 2015/201501/20150101/下的临时或隐藏文件，等。

## 3.2 客户端同步到远程的脚本`rsync.sh`

下面是一个完整的同步脚本，请根据需要进行裁剪，`rsync.sh`：

    #rsync auto sync script with inotify
    #2014-12-11 Sean
    #variables
    current_date=$(date +%Y%m%d_%H%M%S)
    source_path=/tmp/src/
    log_file=/var/log/rsync_client.log

    #rsync
    rsync_server=172.29.88.223
    rsync_user=sean
    rsync_pwd=/etc/rsync_client.pwd
    rsync_module=module_test
    INOTIFY_EXCLUDE='(.*/*\.log|.*/*\.swp)$|^/tmp/src/mail/(2014|20.*/.*che.*)'
    RSYNC_EXCLUDE='/etc/rsyncd.d/rsync_exclude.lst'

    #rsync client pwd check
    if [ ! -e ${rsync_pwd} ];then
        echo -e "rsync client passwod file ${rsync_pwd} does not exist!"
        exit 0
    fi

    #inotify_function
    inotify_fun(){
        /usr/bin/inotifywait -mrq --timefmt '%Y/%m/%d-%H:%M:%S' --format '%T %w %f' \
              --exclude ${INOTIFY_EXCLUDE}  -e modify,delete,create,move,attrib ${source_path} \
              | while read file
          do
              /usr/bin/rsync -auvrtzopgP --exclude-from=${RSYNC_EXCLUDE} --progress --bwlimit=200 --password-file=${rsync_pwd} ${source_path} ${rsync_user}@${rsync_server}::${rsync_module}
          done
    }

    #inotify log
    inotify_fun >> ${log_file} 2>&1 &

`--bwlimit=200`用于限制传输速率最大 200kb，因为在实际应用中发现如果不做速率限制，会导致巨大的 CPU 消耗。

在客户端运行脚本`# ./rsync.sh`即可实时同步目录。

其他功能：[双向同步](http://seanlook/2014/12/13/rsync_two-way_eg)、[sersync2 实时同步多远程服务器](http://seanlook2014/12/16/rsync_sersyc2_muti_remote_dest)

## 参考

- [How Rsync Works](http://rsync.samba.org/how-rsync-works.html)
- [用 inotify 监控 Linux 文件系统事件](https://www.ibm.com/developerworks/cn/linux/l-inotify/)
- [Inotify: 高效、实时的 Linux 文件系统事件监控框架](http://www.infoq.com/cn/articles/inotify-linux-file-system-event-monitoring)
- [rsync 的核心算法](http://coolshell.cn/articles/7425.html)

---

原文链接地址：[http://seanlook.com/2014/12/12/rsync_inotify_setup/](http://seanlook.com/2014/12/12/rsync_inotify_setup/)

---

- [![](https://static.segmentfault.com/v-5d2ffc9a/global/img/creativecommons-cc.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)
- [](<javascript:void(0);>)

  - [举报](#911)

- [新浪微博](<javascript:void(0);>)
- [微信](<javascript:void(0);>)
- [Twitter](<javascript:void(0);>)
- [Facebook](<javascript:void(0);>)

**•••**

赞   |   8 收藏   |  72  
赞赏支持

如果觉得我的文章对你有用，请随意赞赏

OA_show(3);

#### 你可能感兴趣的

- [Linux - 网络 - 基本工具](http://segmentfault.com/a/1190000015482266 "Linux - 网络 - 基本工具")吴宏东[网络](/t/%E7%BD%91%E7%BB%9C)[linux](/t/linux)
- [20170723-Ubuntu 配置 rsync 服务](http://segmentfault.com/a/1190000010310496 "20170723-Ubuntu配置rsync服务")jhhfft[rsync](/t/rsync)
- [remote sync](http://segmentfault.com/a/1190000004293647 "remote sync")feng20068[rsync](/t/rsync)
- [sersync 基于 rsync+inotify 实现数据实时同步](http://segmentfault.com/a/1190000003090889 "sersync基于rsync+inotify实现数据实时同步")王奥 OX[实时同步](/t/%E5%AE%9E%E6%97%B6%E5%90%8C%E6%AD%A5)[inotify-tools](/t/inotify-tools)[inotify](/t/inotify)[rsync](/t/rsync)[sersync](/t/sersync)
- [\[译\] zBackup：一个多功能的去重备份工具](http://segmentfault.com/a/1190000002800728 "[译] zBackup：一个多功能的去重备份工具")陌辞寒[linux](/t/linux)
- [rsync 的使用方法](http://segmentfault.com/a/1190000015669114 "rsync 的使用方法")Sulfonamide[rsync](/t/rsync)[backup](/t/backup)[bash](/t/bash)[linux](/t/linux)[macos](/t/macos)
- [案例:使用 rsync 在 windows 电脑上实现文件同步](http://segmentfault.com/a/1190000007258442 "案例:使用rsync在windows电脑上实现文件同步")旺酱在路上[windows](/t/windows)[rsync](/t/rsync)
- [关于 rsync+inotify-tools 实时同步模式](http://segmentfault.com/a/1190000002558330 "关于rsync+inotify-tools实时同步模式")线上猛如虎[inotify-tools](/t/inotify-tools)[rsync](/t/rsync)

**2 条评论**

[默认排序](javascript:;) [时间排序](javascript:;)

[![](https://static.segmentfault.com/v-5d2ffc9a/global/img/user-64.png)](/u/disanguande)

**[第三关的](/u/disanguande)** · 2015 年 08 月 05 日

chmod 600 /etc/rsyncd.d/rsync_server.pwd 这个是不是错了，是不是更改 secrets file=/etc/rsyncd.secrets 这个路径的文件

chmod 600 /etc/rsyncd.d/rsync_server.pwd 这个是不是错了，是不是更改 secrets file=/etc/rsyncd.secrets 这个路径的文件

赞 回复 取消 保存

[添加回复](javascript:;)

[![](https://static.segmentfault.com/v-5d2ffc9a/global/img/user-64.png)](/u/zszww)

**[追随周文王](/u/zszww)** · 2016 年 12 月 23 日

    while read file
    do
              /usr/bin/rsync -auvrtzopgP --exclude-from=${RSYNC_EXCLUDE} --progress --bwlimit=200 --password-file=${rsync_pwd} ${source_path} ${rsync_user}@${rsync_server}::${rsync_module}
    done

while 循环体中没有使用变量 file，会不会每次有一个文件发生变换，就同步整个文件夹？还是 rsync 会智能的只发送差异文件？

`while read file do /usr/bin/rsync -auvrtzopgP --exclude-from=${RSYNC\_EXCLUDE} --progress --bwlimit=200 --password-file=${rsync\_pwd} ${source\_path} ${rsync\_user}@${rsync\_server}::${rsync\_module} done` while 循环体中没有使用变量 file，会不会每次有一个文件发生变换，就同步整个文件夹？还是 rsync 会智能的只发送差异文件？

赞 回复 取消 保存

[添加回复](javascript:;)

载入中...

[显示更多评论](javascript:;)

![](https://static.segmentfault.com/v-5d2ffc9a/global/img/user-128.png)

发布评论## 目标

去除 iconfinder 上 icon 的水印

### 原理

利用水印像素点和原图像素点颜色合并的原理，如果拥有加过水印的图片和水印图片，就可以反向推出原图原像素点的颜色；前提是你得拥有他的水印图片
