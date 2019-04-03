BIOS电源管理
Winodws自动登陆
开机启动程序
睡眠/电源管理


标签： OpenWrt, Wake-on-LAN, WOL, 网络唤醒, 路由器, 远程开机

标题: OpenWrt实现WOL(Wake-on-LAN)网络唤醒
作者: Demon
链接: http://demon.tw/hardware/openwrt-wake-on-lan.html
版权: 本博客的所有文章，都遵守“署名-非商业性使用-相同方式共享 2.5 中国大陆”协议条款。

Wake-on-LAN简称WOL或WoL，一般翻译为“网络唤醒”、“远端唤醒”，通俗的说就是远程开机。曾经在OpenWrt路由器上面研究过WOL，但是失败了，最近又要用到，折腾了半天终于成功了。

OpenWrt提供了wol和etherwake两个包来实现WOL功能，随便安装一个即可，当然也可以两个都装。

    opkg update
    opkg install wol etherwake

之前失败的罪魁祸首在于运行命令时只指定了MAC地址：

    /usr/bin/wol 40:8D:5C:1F:5D:18
    /usr/bin/etherwake 40:8D:5C:1F:5D:18

这样会向255.255.255.255广播，但是不知为何电脑的网卡收不到，所以开不了机。

正确的做法是，如果用wol，则需要指定向电脑所在的网段广播：

    /usr/bin/wol -i 192.168.1.255 40:8D:5C:1F:5D:18

如果用etherwake，需要指定电脑所在局域网的接口：

    /usr/bin/etherwake -i br-lan 40:8D:5C:1F:5D:18

不喜欢命令行的话也可以安装对应的LuCI包在网页上操作：

    opkg update
    opkg install luci-app-wol

