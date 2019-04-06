- winPE盘 
```
wepe x32/x64/BIOS/UEFI 
主板启动
```

- WinOS 版本 光盘&激活 : 
```
windows8/10 微软官网http下载
msdnItellu ed2k 迅雷
``` 

品牌机OEM自动激活
kms不支持 旗舰版/零售版
kms支持 大客户版VL
```
win10专业版
按 win+X 组合键，打开“命令提示符(管理员)（A）”。
slmgr -ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
slmgr -skms kms.landian.news
slmgr -ato
键入slmgr -xpr，回车可查看到期时间，激活有效时间为半年。这不是永久激活，需要通过正规渠道购买激活密钥激活。
```


- driver
官网页面/驱动支持
```
lenovodm.exe自动驱动
asusLiveUpdate https://www.asus.com.cn/support/Download-Center/ 
```



- Office 
LibreOffice/
MSOffice 激活 
```
cd to %office15% 
cscript ospp.vbs /sethst:127.0.0.2 
cscript ospp.vbs /act
```

- windows修复
驱动/注册表 ： 系统还原
系统文件修复：
```
使用sfc和dism命令修复系统有哪些区别？
```

- windows 系统备份映像
wim/gho


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
portable_green-software
sandboxie
UAC
```
