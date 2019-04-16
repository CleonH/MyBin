## windowws %APPDATA%
```
Local和LocalLow都是存储本地用户运行的程序的记录、设置文件，不同的是LocalLow专门存储优先级比较低（low integrity）的程序的文件。因为优先级低的程序没有足够的权限写入到更敏感的位置（比如Local，当然还有其他位置和注册表的对应位置）。Local是最主要的存储位置，所以相对占的空间比较大。这个文件夹相当于XP时代的Documents and Settings\UserName\Local Settings\Application Data
Roaming顾名思义，是存储可以“漫游”的用户配置，例如程序中自定义的存储路径（比如迅雷的下载目录），这些设置需要跟随系统用户配置一起移动。它相当于XP的Documents and Settings\UserName\Application Data
```

qdir - Q-Dir.ini

everything - everything.ini
