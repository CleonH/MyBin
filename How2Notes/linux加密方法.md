## Index
- gzexe 加密压缩,脚本隐藏脚本密码
- tar + openssl 打包，外层加密（目录？）
- shc   针对shell脚本加密
- zip   文件/文件夹加密，目录不加密
- GnuPG 只能对文件进行加密，对目录则无法完成加密
- *ccrypt*
- *encfs*
- *disk encryption*
- *ovelay-fs encryptioin*

###  gzexe
这种加密方式不是非常保险的方法，但是能够满足一般的加密用途，可以隐蔽脚本中的密码等信息。
它是使用系统自带的gzexe程序，它不但加密，同时压缩文件。
gzexe方法会把原来没有加密的文件a.txt备份为a.txt~ ,同时a.txt文件变成了加密文件（即变成了密文）

使用-d参数进行解压操作


### tar命令 对文件加密压缩和解压 
```
[root@ipsan-node03 ~]# ls
test.txt
[root@ipsan-node03 ~]# cat test.txt
hahahaha
heiheihei
   
如下命令是对filename文件（test.txt）进行加密压缩，生成filename.des3加密压缩文件，123@123为加密的密码
[root@ipsan-node03 ~]# tar -zcf - test.txt |openssl des3 -salt -k 123@123 | dd of=test.txt.des3
0+1 records in
0+1 records out
152 bytes (152 B) copied, 0.00333366 s, 45.6 kB/s
 
---------------------------------------------------------------------------------------------------------
也可以将/mnt目录下的所有文件全部加密压缩
[root@ipsan-node03 ~]# tar -zcf - /mnt/* |openssl des3 -salt -k 123@123 | dd of=test.des3
 
或者根据匹配规则进行加密压缩
[root@ipsan-node03 ~]# tar -zcf - /mnt/pass_* |openssl des3 -salt -k 123@123 | dd of=test.des3
---------------------------------------------------------------------------------------------------------
   
通常加密后，会将源文件删除
[root@ipsan-node03 ~]# ls
test.txt  test.txt.des3
[root@ipsan-node03 ~]# rm -f test.txt
[root@ipsan-node03 ~]# cat test.txt.des3
Salted__H¡+ZCHaW⃟׬
                 \bS©|>þHބ*𓑂ܪ³󾯵@ⴹ񑋟𻹾qk)B㲏¡qk;ochl\cz-𤥴/흯
¤ވտ+¾´2AuK𷁆픏̞t悐ah¤ºʀ񧦇d
   
解压操作：
[root@ipsan-node03 ~]# dd if=test.txt.des3 |openssl des3 -d -k 123@123 | tar zxf -
0+1 records in
0+1 records out
152 bytes (152 B) copied, 4.5873e-05 s, 3.3 MB/s
   
[root@ipsan-node03 ~]# ls
test.txt  test.txt.des3
[root@ipsan-node03 ~]# cat test.txt
hahahaha
heiheihei
   
注意命令最后面的"-",它将释放所有文件，
-k 123@123可以没有，没有时在解压时会提示输入密码

```

结合Tar和OpenSSL给文件和目录加密及解密
```
当有重要的敏感数据的时候，给文件和目录额外加一层保护是至关重要的，特别是当需要通过网络与他人传输数据的时候。基于这个原因，
可以用到tar（Linux 的一个压缩打包工具）和OpenSSL来解决的方案。借助这两个工具，你真的可以毫不费力地创建和加密 tar 归档文件。
 
下面介绍使用 OpenSSL创建和加密 tar 或 gz（gzip，另一种压缩文件）归档文件：
牢记使用 OpenSSL 的常规方式是：
# openssl command command-options arguments
 
示例如下：
[root@ipsan-node03 ~]# cd /mnt/
[root@ipsan-node03 mnt]# ls
[root@ipsan-node03 mnt]# echo "123" > a.txt
[root@ipsan-node03 mnt]# echo "456" > b.txt
[root@ipsan-node03 mnt]# echo "789" > c.txt
[root@ipsan-node03 mnt]# ls
a.txt  b.txt  c.txt
 
现在要加密当前工作目录的内容（根据文件的大小，这可能需要一点时间）
[root@ipsan-node03 mnt]# tar -czf - * | openssl enc -e -aes256 -out test.tar.gz
enter aes-256-cbc encryption password:                          //假设这里设置的密码为123456
Verifying - enter aes-256-cbc encryption password:
 
上述命令的解释：
enc 使用加密进行编码
-e  用来加密输入文件的 enc 命令选项，这里是指前一个 tar 命令的输出
-aes256 加密用的算法
-out 用于指定输出文件名的 enc 命令选项，这里文件名是test.tar.gz
 
[root@ipsan-node03 mnt]# ls
a.txt  b.txt  c.txt  test.tar.gz
[root@ipsan-node03 mnt]# rm -rf a.txt
[root@ipsan-node03 mnt]# rm -rf b.txt
[root@ipsan-node03 mnt]# rm -rf c.txt
[root@ipsan-node03 mnt]# ls
test.tar.gz
 
对于上面加密后的tar包直接解压肯定是不行的！
[root@ipsan-node03 mnt]# tar -zvxf test.tar.gz
gzip: stdin: not in gzip format
tar: Child returned status 1
tar: Error is not recoverable: exiting now
 
要解密上述tar归档内容，需要使用以下命令。
[root@ipsan-node03 mnt]# openssl enc -d -aes256 -in test.tar.gz | tar xz -C /mnt/
enter aes-256-cbc decryption password:
[root@ipsan-node03 mnt]# ls
a.txt  b.txt  c.txt  test.tar.gz
 
上述命令的解释：
-d  用于解密文件
-C  将加压后的文件提取到目标目录下
 
当你在本地网络或因特网工作的时候，你可以随时通过加密来保护你和他人共享的重要文本或文件，这有助于降低将其暴露给恶意攻击者的风险。
```

### shc加密（仅仅对shell脚本加密）
```
shc是一个专业的加密shell脚本的工具.它的作用是把shell脚本转换为一个可执行的二进制文件，这个办法很好的解决了脚本中含有IP、
密码等不希望公开的问题。
  
如果你的shell脚本包含了敏感的口令或者其它重要信息, 而且你不希望用户通过ps -ef(查看系统每个进程的状态)捕获敏感信息. 你可以
使用shc工具来给shell脚本增加一层额外的安全保护. shc是一个脚本编译工具, 使用RC4加密算法, 它能够把shell程序转换成二进制可执
行文件(支持静态链接和动态链接). 该工具能够很好的支持: 需要加密, 解密, 或者通过命令参数传递口令的环境.
  
shc的官网下载地址: 
http://www.datsi.fi.upm.es/~frosal/sources/
  
安装方法：
[root@ipsan-node03 ~]# cd /usr/local/src/
[root@ipsan-node03 src]# wget http://www.datsi.fi.upm.es/~frosal/sources/shc-3.8.9.tgz
[root@ipsan-node03 src]# tar -zvxf shc-3.8.9.tgz
[root@ipsan-node03 src]# cd shc-3.8.9
[root@ipsan-node03 shc-3.8.9]# mkdir -p /usr/local/man/man1
这步是必须的，不然安装过程中会报错，shc将安装命令到/usr/local/bin/目录下；
将帮助文档存放在/usr/local/man/man1/目录下，如果系统中无此目录，安装时会报错，可创建此目录后再执行安装
  
[root@ipsan-node03 shc-3.8.9]# make install
这是要回答yes或者y，不能直接回车，否则会报错
  
需要注意的是，sch只能能shell脚本文件进行加密，其他文件都不可以！
  
sch加密使用方法:
"-f"选项指定需要加密的程序
[root@ipsan-node03 ~]# ls
text.sh
[root@ipsan-node03 ~]# cat text.sh
#!/bin/bash
echo "hahaha"
[root@ipsan-node03 ~]# shc -r -f text.sh
[root@ipsan-node03 ~]# ls
text.sh  text.sh.x  text.sh.x.c
  
注意:要有-r选项, -f 后跟要加密的脚本名。
运行后会生成两个文件,script-name.x 和 script-name.x.c
script-name.x是加密后的可执行的二进制文件.
./script-name.x 即可运行.
script-name.x.c是生成script-name.x的原文件(c语言)
[root@ipsan-node03 ~]# ./text.sh
hahaha
[root@ipsan-node03 ~]# ./text.sh.x
hahaha
  
通常从安全角度考虑：
使用sch命令对shell脚本文件进行加密后，只需保留.x的二进制文件即可，其他两个文件均可以删除！
[root@ipsan-node03 ~]# ls
text.sh  text.sh.x  text.sh.x.c
[root@ipsan-node03 ~]# rm -rf text.sh
[root@ipsan-node03 ~]# rm -rf text.sh.x.c
[root@ipsan-node03 ~]# ls
text.sh.x
[root@ipsan-node03 ~]# ./text.sh.x
hahaha
  
另外：
shc还提供了一种设定有效执行期限的方法，可以首先使用shc将shell程序转化为二进制，并加上过期时间，如：
[root@ipsan-node03 ~]# shc -e 28/02/2018 -m "this script file is about to expire" -v -r -f text.sh
shc shll=bash
shc [-i]=-c
shc [-x]=exec '%s' "$@"
shc [-l]=
shc opts=
shc: cc  text.sh.x.c -o text.sh.x
shc: strip text.sh.x
shc: chmod go-r text.sh.x
[root@ipsan-node03 ~]# ls
text.sh  text.sh.x  text.sh.x.c
  
解释：
-e:指定过期时间为2018年2月28日
-m:过期后打印出的信息；
-v: verbose
-r: 可在相同操作系统的不同主机上执行
-f: 指定源shell
  
如果在过期后执行，则会有如下提示：
[root@ipsan-node03 ~]# ./text.sh.x
./text.sh.x: this script file is about to expire
使用以上方法要注意，需防止用户更改系统时间，可以通过在程序中加入自动更新系统时间的命令来解决此问题！！
  
sch的帮助命令：
[root@ipsan-node03 ~]# shc -help
shc Version 3.8.9, Generic Script Compiler
shc Copyright (c) 1994-2012 Francisco Rosales <frosal@fi.upm.es>
shc Usage: shc [-e date] [-m addr] [-i iopt] [-x cmnd] [-l lopt] [-rvDTCAh] -f script
  
    -e %s  Expiration date in dd/mm/yyyy format [none]   （指定过期日期）
    -m %s  Message to display upon expiration ["Please contact your provider"]  （指定过期提示的信息）
    -f %s  File name of the script to compile   （指定要编译的shell的路径及文件名）
    -i %s  Inline option for the shell interpreter i.e: -e
    -x %s  eXec command, as a printf format i.e: exec('%s',@ARGV);
    -l %s  Last shell option i.e: --
    -r     Relax security. Make a redistributable binary   （可以相同操作系统的不同系统中执行）
    -v     Verbose compilation    （编译的详细情况）
    -D     Switch ON debug exec calls [OFF]
    -T     Allow binary to be traceable [no]
    -C     Display license and exit
    -A     Display abstract and exit
    -h     Display help and exit
  
    Environment variables used:
    Name    Default  Usage
    CC      cc       C compiler command
    CFLAGS  <none>   C compiler flags
  
    Please consult the shc(1) man page.
  
说明：
经测试，相同在操作系统，shc后的可执行二进制文件直接可以移植运行，但不同操作系统可能会出现问题，
比如将上面的test.sh.x的二进制文件在CentOS6.9上加密后移到redhat as5u4上不能运行，出现"Floating point exception"错误提示，
但移到另一台CentOS6.9上直接运行没问题。
```

### ZIP加密

1）文件加密
使用命令"zip -e filename.zip filename" 即可出现输入密码的提示，输入2次密码。 此文件即被加密解压时候是需要密码的
2）文件夹加密
使用命令"zip -re dirname.zip dirname"即可出现输入密码的提示，输入2次密码。 此文件即被加密解压时候是需要密码的。

### GnuPG加密

GnuPG的全称是GNU隐私保护(GNU Privacy Guard)，常常被称为GPG，它结合了一组加密软件。它是由GNU项目用C编程语言编写的。最新的稳定版本是2.0.27。在如今的大多数Linux发行版中，gnupg程序包都是默认随带的，所以万一它没有安装，你可以使用apt或yum从软件库来安装它（yum install gnupg）。注意：gpg只能对文件进行加密，对目录则无法完成加密！
```
下面开始使用GnuPG方式对test.txt文件进行加密
[root@centos6-vm02 ~]# cat test.txt
this is a test!!!
[root@centos6-vm02 ~]# gpg -c test.txt   
can't connect to `/root/.gnupg/S.gpg-agent': No such file or directory         //这个信息可以忽略
 
注意：如上加密的时候，会弹出来一个对话框，要求Paraphrase输入两次密码，对这个特定的文件进行加密。
 
一旦运行带-c选项(完全使用对称密码算法加密)的gpc命令，它会生成一个文件.gpg文件。
[root@centos6-vm02 ~]# ll test.txt*
-rw-r--r--. 1 root root 18 Jan  4 10:08 test.txt
-rw-r--r--. 1 root root 61 Jan  4 10:04 test.txt.gpg
 
对文件进行加密后，最好将源文件删除！不要再保留源文件了！
[root@centos6-vm02 ~]# rm -f test.txt
 
文件解密操作。
注意出现Paraphrase提示时，需要提供加密时输入的同一个密码才能解密
[root@centos6-vm02 ~]# gpg test.txt.gpg  
gpg: 3DES encrypted data
can't connect to `/root/.gnupg/S.gpg-agent': No such file or directory
gpg: encrypted with 1 passphrase
gpg: WARNING: message was not integrity protected
[root@centos6-vm02 ~]# ll test.txt*
-rw-r--r--. 1 root root 18 Jan  4 10:08 test.txt
-rw-r--r--. 1 root root 61 Jan  4 10:04 test.txt.gpg
[root@centos6-vm02 ~]# cat test.txt
this is a test!!!
```
