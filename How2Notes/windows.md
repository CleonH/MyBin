- winPE盘 
```
wepe x32/x64/BIOS/UEFI （UltraISO写入硬盘，添加引导）

主板启动引导按键：ESC，F1~F12,DEL
```

- WinOS 版本 光盘&激活 : 
```
windows8/10 微软官网http下载
msdnItellu ed2k 迅雷

WEPE下直接挂载光盘安装
ultraISO刻录，添加启动引导，主板启动u盘安装
rufus/yumi_multiboot/unetbootin/etcher

磁盘格式GPT可能不支持/MGR支持，winxp/win7不支持UEFI/GPT，win7支持MBR
！系统引导修复，linuxGrub多启动，etc。。。
```
``` 
品牌机OEM自动激活
kms不支持 旗舰版/零售版
kms支持 大客户版VL
```
```
win10专业版
按 win+X 组合键，打开“命令提示符(管理员)（A）”。
slmgr -ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
slmgr -skms kms.landian.news  （KMS服务器地址，可用未知）
slmgr -ato
键入slmgr -xpr，回车可查看到期时间，激活有效时间为半年。这不是永久激活，需要通过正规渠道购买激活密钥激活。
```


- driver
官网页面/驱动支持
```
lenovodm.exe自动驱动
asusLiveUpdate https://www.asus.com.cn/support/Download-Center/ 
管理员权限，运行compmgmt，设备管理器，驱动安装检查顺序- 主板/网卡，intel集成显卡，其他
(winxp/win7无免驱动网卡时，先查型号，到官网下载驱动u盘拷贝。  官网驱动找不到，驱动精灵网卡集成版）

！驱动安装好后，备份映像
！备份映像好后，开启系统还原点
！设置还原点后，开始装软件
```



- Office 
! 替代 LibreOffice_portable
! 激活 MSOffice
```
cd to %office15% 
cscript ospp.vbs /sethst:127.0.0.2  （KMS服务器地址，不可用）
cscript ospp.vbs /act
```

- windows修复

```
+驱动/注册表 ：
系统还原点

+系统文件修复：
360系统重装大师？ 保留用户文件？
使用sfc和dism命令修复系统有哪些区别？
。。。
```

- windows 系统备份映像
```
wim/gho
出厂一键修复
```

- windows8/10 还原系统而不删除你的文件
```
如果自己就有win8的ISO或是已经下载好了，需要设置调用目录。
在E盘目录下，新建一个文件，命名为win8，将ISO放入并解压在这个文件里面。
然后将鼠标移到左下角，点击右键，会出现一个列表，点击“命令提示符（管理员）”，
输入“reagentc /setosimage /path E:\win8\sources /index 1”，
回车，屏幕提示“操作成功”。再次在命令提示符输入“reagentc /info”，
确保其中的“恢复映像索引”显示为“1”，恢复映像位置是E:\win8\sources  
当然，你解压的是在D或是F盘也一样，我是按照我的E盘来说的。
如果在恢复时，还是提示插入介质，说明你的调用目录没有设置好，可能命令输入有误，多试几遍。

建议恢复电脑之前删除你安装的所有应用软件，恢复电脑不会丢失你的文件，
但因为是重装系统，清除了你C盘的软件注册表，会清除软件信息，重装后需要重新安装。
重装后，你的电脑C盘里面会生成一个几G大小的old文件，
这是旧系统的备份，便于今后有需要找回旧系统文件，这个可以删除，对C盘进行磁盘清理然后选择删除就行。
```


- 软件/防火墙/用户权限
```
管理员账号密码/UAC/sandboxie
常用软件：7zip/everything/sumatraPDF/thunder
绿色软件文件扩展名关联
绿色软件portableapps/sandboxie沙盘拷贝
输入法/浏览器插件/全局代理服务器-internet选项-局域网设置/网卡ipv4-DNS
开机自启动项目 -禁止
后台服务项目 -禁止
windows搜索路径-删appdata
windows自动更新- 禁用？



===============


【微软windows签名认证】 签名，证书，正版，原版。
*HashMyfile 文件指纹检查

WEPE 工具箱   http://www.wepe.com.cn/
MS-Win7/8/10 操作系统 https://msdn.itellyou.cn/ （大客户版KMS/OEM主板激活，迅雷下载，hash检查）

MS-Office  应用程序 https://msdn.itellyou.cn/   （大客户版KMS激活，迅雷下载，hash检查）
LibreOffice  开源，兼容 https://zh-cn.libreoffice.org/


火狐浏览器  https://www.firefox.com.cn
谷歌浏览器  https://www.google.cn/intl/zh-CN/chrome/browser/?standalone=1

firefox浏览器插件  https://addons.mozilla.org/zh-CN/firefox/
adblock  https://addons.mozilla.org/zh-CN/firefox/addon/adblock-plus/
OneTab   https://addons.mozilla.org/zh-CN/firefox/addon/onetab/
印象剪藏  https://addons.mozilla.org/zh-CN/firefox/addon/evernote-web-clipper/


系统内置输入法
小狼毫输入法  https://rime.im/
*谷歌输入法/qq输入法/必应输入法  http://qq.pinyin.cn/



VLC播放器   https://www.videolan.org/
*qq播放器   http://player.qq.com/

7zip解压缩  https://sparanoid.com/lab/7z/
*bandzip解压缩  https://www.bandisoft.com/bandizip/


Everything 查文件  https://www.voidtools.com/zh-cn/downloads/
AllDup 找重复文件  http://www.alldup.de/en_download_alldup.php

aria2-uget  https://ugetdm.com/
aria2-motrix https://motrix.app/
qbittorrent
*迅雷绿色版/小米路由器远程下载


SumatraPDF阅读器（mobi,epub)  https://www.sumatrapdfreader.org/download-free-pdf-viewer.html
goldendict  http://goldendict.org/
*欧陆词典  http://dict.eudic.net/
*有道词典


印象笔记/evernote  https://www.yinxiang.com
OneNote   https://www.onenote.com/Download


备选：
PortableApps 绿色软件 https://portableapps.com/
sandboxie 沙盘软件   https://www.sandboxie.com/
geek uninstaller 卸载工具 https://geekuninstaller.com/
ccleaner 清理工具  https://www.ccleaner.com/ccleaner
recuva 误删恢复    https://www.ccleaner.com/recuva


黑名单：（管理员权限）
360杀毒/360安全卫士
迅雷安装版
美图秀秀
搜狗输入法
xx播放器



================
```

- 自动登陆/计划任务/电源管理/
```
control userpasswords2
autohotkey
autopoweroff
后台服务
计划任务
```

- windows smb / ftpd
```
小米路由器文件共享
群晖NAS文件服务器


* filezilla，防火墙端口/启动服务/管理员密码/用户/路径/tls证书

* WinServer 服务
为windows开启ftp功能：控制面板-->程序和功能-->打开或关闭Windows功能
添加FTP站点：打开控制面板-->管理工具-->双击Internet信息服务（IIS）管理器如下图添加FTP站点

```



