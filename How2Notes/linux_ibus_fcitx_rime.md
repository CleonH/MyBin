### switch ibus/fcitx

```
用了好久的fcitx输入法，今天切换为ibus输入法遇到了麻烦。后来发现其实挺简单的，步骤跟我4年前写的某篇博文一样。

第1步，要保证桌面启动的时候启动ibus-daemon。方法是在/etc/xdg/autostart（或~/.config/autostart）文件夹里建立一个可执行的ibus.desktop文件，内容如下：

[Desktop Entry]
Exec=ibus-daemon -xdr
GenericName=IBus
Name[zh_CN]=IBus
Name=IBus
Name[en_US]=IBus
StartupNotify=true
Terminal=false
Type=Application

第1.1步，在/etc/xdg/autostart（或~/.config/autostart）文件夹里打开终端，执行chmod 755 ibus.desktop命令使ibus.desktop可执行。

第1.2步，如果之前安装了fcitx输入法，它会自动在/etc/xdg/autostart建立启动项，要删除之，如果~/.config/autostart也有，也要删除之。建议在删除之前压缩打包。

第2步，要保证ibus跟GTK、QT等应用融合。方法是在/etc/profile（或~/.xprofile）结尾处加入以下内容：

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

最后，注销桌面或重启系统。
后面的话：

ArchWiki上的ibus手册都已经过时了，会害人的。还有在运行ibus-setup命令的时候提示在~/.bashrc里添加export GTK_IM_MODULE=ibus
之类的字样，对使用了显示管理器的用户也是无效的，只有添加到~/.xprofile或/etc/profile里才是最好的。

本方法也可适用于ibus切换为fcitx。
```


### rime 
```




```
