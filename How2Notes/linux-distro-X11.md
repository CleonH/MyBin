homebrew for linux 
- https://nixos.org
- http://www.gnu.org/software/guix/
```
作者：Haoyuan Xing
链接：https://www.zhihu.com/question/20022687/answer/45125110

在Linux下使用Homebrew意义不大。Homebrew之所以这么设计，很大程度上是为了绕开Mac OS X系统设计中的问题。
但是按Linux的标准来看，Homebrew是一个实现的很糟糕的包管理器：使用用户本身权限编译软件，而非fakeroot编译环境，带来安全隐患破坏/usr/local的权限（和内容）和系统本身的软件包常常冲突很多软件仍然需要大量重编译由于依赖OS X的库，升级系统很容易带来软件包乃至homebrew自身的运行问题存在可以实现homebrew的软件包管理器，没有必要继续重造轮子
根本原因是因为，OS X没有内置的软件包管理机制，所以任何其他的软件包管理器都不得迁就OS X本身自带的软件版本，而在Linux下，一般系统中所有的软件包版本，都由发行版本身的软件包管理器分发和维护，这样保证了系统的稳定、没有冲突。
对于CentOS来说，系统自带的yum已经可以完成大部分的软件管理工作 PackageManagement
CentOS是以『稳定』为第一考量的发行版，所以不建议重新编译软件，参见 PackageManagement/SourceInstalls
你可以自己对软件进行打包，然后安装 HowTos/SetupRpmBuildEnvironment
如果你喜欢最新的软件版本，请尝试ArchLinux
如果你喜欢源码编译，类似ports的系统，请尝试Gentoo Linux发行版

当然，安装在userspace的软件包管理器也有它的好处，如果你需要类似homebrew这样，安装在userspace的软件包管理器，请参考nix(https://nixos.org/nix/)和GNU Guix
```

## X11  - https://distrowatch.com/

- kde
- xfce 
- lxde
- gnome
- mint
- *PIXEL* for raspbian https://distrowatch.com/table.php?distribution=raspbian


## about
- xfce about
```
Xfce 是一个提供全功能桌面环境的程序集。以下程序是 Xfce 核心的部分：

窗口管理器 (xfwm4)
处理窗口在屏幕上的位置摆放

面板 (xfce4-panel)
程序启动器、窗口按钮、应用程序菜单、工作区切换器等等。

桌面管理器 (xfdesktop)
设置背景的颜色或图片，可选应用程序菜单或最小化应用程序、启动器、设备文件夹的图标。

文件管理器 (thunar)
Unix/Linux 桌面的现代文件管理器，旨在易用和快速。

会话管理器 (xfce4-session)
在桌面启动时恢复您的会话并让您从 Xfce 关闭计算机。

设置系统 (xfce4-settings)
控制桌面的如外观、显示、键盘和鼠标设置各个方面的配置系统。

应用程序查找器 (xfce4-appfinder)
分类显示在您系统上安装的应用程序，这样您就可以快速地查找和启动它们。

设置守护进程 (xfconf)
基于 D-Bus 的配置存储系统。

Xfce 还是一个提供若干库文件，帮助程序员创建适合桌面环境的应用程序的开发平台。

Xfce 组件以自由或开源许可协议授权；应用程序以 GPL 或 BSDL，库文件以 LGPL 或BSDL 授权。看文档、源代码或 Xfce 站点(http://www.xfce.org) 获取详情。

感谢您对 Xfce 感兴趣。

	- Xfce 开发团队

```
