- 硬件
```
 生活办公CPU，用核心显卡 （CPU+GPU，电池，酷睿i3/i5/酷睿M）
 固态硬盘接口类型：PCIE/mSATA/SATA/板载EMMC
 -笔记本硬盘位换SSD，光驱位装HDD
 -笔记本内存插槽（可升级，单条支持最高容量，BIOS/UEFI）
 -笔记本板载内存（不可升级，办公2G/4G）
 
 文件共享，远程访问：NAS文件服务器/路由器USB硬盘
 路由器百兆/千兆，无线路由2.4GHz/5GHz。上网速度/内网速度瓶颈，淘汰顺序：2.4GHz/USB2/百兆/(带宽)/5Ghz/千兆/USB3
```
- WinPE 启动盘
```
wepe x32/x64/BIOS/UEFI （UltraISO写入硬盘，添加引导）
WEPE 工具箱   http://www.wepe.com.cn/
主板启动引导按键：ESC，F1~F12,DEL
```

- WinOS光盘&安装&激活 : 

step1)[光盘下载]
```
[方法一] ed2k链接
MS-Win7/8/10 操作系统 https://msdn.itellyou.cn/ （vl大客户版KMS/OEM主板激活，迅雷ed2k下载，hash检查）
MS-Office  应用程序 https://msdn.itellyou.cn/   （vol大客户版KMS激活，迅雷ed2k下载，hash检查）

[方法二] windows8/10 微软官网 
https://www.microsoft.com/zh-cn/software-download/windows8ISO
https://www.microsoft.com/zh-cn/software-download/windows10
```

step2)[安装系统]
```
[方法一]WEPE下直接挂载光盘安装
[方法二]微软官网 MediaCreationTool 使用该工具创建安装介质（USB/光盘），以在其他电脑上安装 Windows 10
[方法三]*ultraISO刻录，添加启动引导，主板启动u盘安装
[方法四]rufus/yumi_multiboot/unetbootin/etcher

【警告】
！菜鸟新手请勿 格式化磁盘，增删分区，修个分区表，备份还原。
！菜鸟请用win8/10自带系统恢复，“恢复你的系统而不删除文件”
！磁盘格式GPT可能不支持，（菜鸟新手格式化磁盘为MGR丢失全盘数据），winxp/win7不支持UEFI/GPT，win7支持MBR
！系统引导修复，linuxGrub多启动，etc。。。
```
step3)[系统激活]

品牌机OEM自动激活       （**版权合法**）

kms不支持 旗舰版/零售版 （**版权非法，大型企业学校勿用，请询问企业学校管理员**）

kms支持 大客户版VL      （**版权非法，大型企业学校勿用，请询问企业学校管理员**）

``` 
win10专业版
按 win+X 组合键，打开“命令提示符(管理员)（A）”。
slmgr -ipk W269N-WFGWX-YVC9B-4J6C9-T83GX （try another KEY；key MUST be comp with os version；using “wmic os get caption” to get os verdion if you dont konw）
slmgr -skms kms.win.server  （KMS server 服务器地址，不可用；try another）
slmgr -ato   （TRY TO ACTIVE；IF SUCCESS键入slmgr -xpr，回车可查看到期时间；IF NOT，repeat try another key or server）
激活有效时间为半年。这不是永久激活，需要通过正规渠道购买激活密钥激活。
```


- 硬件驱动driver安装
官网页面/驱动支持
```
联想驱动自动安装工具lenovodm.exe https://think.lenovo.com.cn/support/driver/mainpage.aspx#ThinkPad
华硕asusLiveUpdate https://www.asus.com.cn/support/Download-Center/ 

检查驱动安装完整：
管理员权限，运行compmgmt.msc，设备管理器，驱动安装检查顺序 【主板/网卡 -> intel集成显卡 -> 其他】
(winxp/win7无免驱动网卡时，先查型号，到官网下载驱动u盘拷贝。  官网驱动找不到，驱动精灵网卡集成版）

！驱动安装好后，备份映像
！备份映像好后，开启系统还原点
！设置还原点后，开始装软件
```



- 常用Office系列

【1】 开源替代 LibreOffice_portable （格式兼容很完美，开源无广告，portable版本免安装）

主页 htdvytps://zh-cn.libreoffice.org 

中科大镜像站 http://mirrors.ustc.edu.cn/tdf/libreoffice/stable/

便携版 https://portableapps.com/apps/office/libreoffice_portable

清华镜像站 https://mirrors.tuna.tsinghua.edu.cn/libreoffice/libreoffice/portable/

【2】KMS激活 微软Office  （**版权非法，大型企业学校勿用，请询问企业学校管理员**）

微软Office安装光盘，迅雷ed2k下载，md5指纹检查
```
打开word选项,找到激活页,输入密钥
win+X；CMD（admin）；cd to %office15安装目录%  
cscript ospp.vbs /sethst:127.0.0.2  （KMS服务器地址，不可用）
cscript ospp.vbs /act （尝试激活,成功有提示success,失败则试其他密钥或服务器）
```


- windows 系统备份映像
```
wim/gho 原厂一键修复的备份映像文件，不要删除
WEPE恢复备份工具，菜鸟新手恢复分区，注意盘符，小心丢失数据
菜鸟请用win8/10自带系统恢复，“恢复你的系统而不删除文件”
```

- windows8/10 还原系统而不删除你的文件
https://jingyan.baidu.com/article/64d05a0276f53fde55f73bcf.html

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
```

- 常用软件
```
========================================================
软件签名，证书，正版，原版 【windows安装程序签名】  【*HashMyfile 文件指纹检查md5/sha1/sha256】
网站白名单：https://alternativeto.net/software/libreoffice/
网站黑名单：sourceforge/百度/华军/（sina部分）
========================================================
---------------------
！杀毒软件：
win7-MS-Essencial
Win8/10内置
*火绒安全
--------------------

------------------------------------------------------------------
！软件黑名单：（普通软件不会要求，UAC管理员权限）
360杀毒/360安全卫士   迅雷安装版  美图秀秀 搜狗输入法   xx播放器
...（UAC警告，管理员权限）
------------------------------------------------------------------

-------------------------------------------------------------------------------
！软件白名单：（推荐）
win8/10 微软自带uwp商店 QQ/微信/百度云 （国产软件尽量用UWP版本）
PortableApps 绿色软件 https://portableapps.com/

autohotkey自动化 https://www.autohotkey.com/

*谷歌浏览器  https://www.google.cn/intl/zh-CN/chrome/browser/?standalone=1
火狐浏览器 https://www.mozilla.org/en-US/firefox/all/
firefox 安装包 https://download.mozilla.org/?product=firefox-latest-ssl&os=win64&lang=zh-CN
firefox 便携版 https://portableapps.com/apps/internet/firefox_portable

firefox浏览器插件  https://addons.mozilla.org/zh-CN/firefox/
adblock  https://addons.mozilla.org/zh-CN/firefox/addon/adblock-plus/
OneTab   https://addons.mozilla.org/zh-CN/firefox/addon/onetab/
印象剪藏  https://addons.mozilla.org/zh-CN/firefox/addon/evernote-web-clipper/


win微软内置输入法 （词库https://github.com/studyzy/imewlconverter）
rime小狼毫输入法  https://rime.im/ （Rime导入搜狗词库  https://www.jianshu.com/p/300bbe1602d4   https://www.cnblogs.com/frederichchen/p/5074689.html https://www.baidu.com/s?ie=utf-8&f=8&rsv_bp=1&rsv_idx=1&tn=baidu&wd=%E5%B0%8F%E7%8B%BC%E8%B1%AA%20%E8%AF%8D%E5%BA%93）
*qq输入法/必应输入法/谷歌输入法  http://qq.pinyin.cn/ （qq拼音词库 https://github.com/studyzy/imewlconverter/wiki/QQ_Pinyin_Win）

VLC播放器   https://www.videolan.org/
*qq播放器   http://player.qq.com/

7zip解压缩（rar/zip/7z格式绑定） https://sparanoid.com/lab/7z/    https://www.7-zip.org/
*bandzip解压缩  https://www.bandisoft.com/bandizip/

qdir 多窗文件管理器 http://www.softwareok.com/?Download=Q-Dir
Everything 查文件  https://www.voidtools.com/zh-cn/downloads/

AllDup     找重复文件   http://www.alldup.de/en_download_alldup.php
WinDirStat 找大体积文件 https://windirstat.net/

SumatraPDF阅读器（mobi,epub)  https://www.sumatrapdfreader.org/download-free-pdf-viewer.html

goldendict  http://goldendict.org/
*欧陆词典  http://dict.eudic.net/
*有道词典

印象笔记/evernote  https://www.yinxiang.com
OneNote   https://www.onenote.com/Download

aria2-uget  https://ugetdm.com/
aria2-motrix https://motrix.app/
qbittorrent/utorrent204
*迅雷绿色版/小米路由器远程下载

Sublime/NotePadPlusPlus 纯文本
Markdown/LaTex  格式文本 typora/cTex
Meld/WinMerge/Kdiff 文本对比
Git/SparkleShare/MSWord 版本管理

-------------------------------------------------------------------------------

-----------------------------------------------

备选：
sandboxie 沙盘软件   https://www.sandboxie.com/
geekuninstaller 卸载工具 https://geekuninstaller.com/
ccleaner 清理工具  https://www.ccleaner.com/ccleaner
recuva 误删恢复    https://www.ccleaner.com/recuva

自动备份工具：SparkleShare/Duplicati/FreeFileSync
同步云：OneDrive/微云同步/坚果云
私有云：SeaFile/NextCloud/可道云/群晖NAS
-----------------------------------------------
```



- 自动登陆/计划任务/电源管理/
```
control userpasswords2
autohotkey
autopoweroff
后台服务
计划任务
```

- Windows修复
```
+ 驱动/注册表 ：
系统还原点

+ 系统文件修复：
360系统重装大师？ 保留用户文件？
使用sfc和dism命令修复系统有哪些区别？
热备份，热修复，dism，dism++
```

- 存储服务器 smb / ftpd
```
win存储池/局域网文件共享
小米路由器文件共享/远程读写
群晖NAS文件服务器/远程读写
FreeNAS/ZFS

* filezilla-FTP，防火墙端口/启动服务/管理员密码/用户/路径/tls证书
* WinServer-FTP服务
为windows开启ftp功能：控制面板-->程序和功能-->打开或关闭Windows功能
添加FTP站点：打开控制面板-->管理工具-->双击Internet信息服务（IIS）管理器如下图添加FTP站点

```
