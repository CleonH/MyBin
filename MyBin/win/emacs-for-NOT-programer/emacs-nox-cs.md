### [tutorial]

http://ergoemacs.org/emacs/emacs_make_modern.html

https://zilongshanren.com/LearnEmacs/

### install windows-emacs
[download] 
https://www.gnu.org/software/emacs/download.html#windows

```
c:\emacs-win\
---/.emacs.d
---/emacs-26
---/.history
```

[regedit] 
emacs-path.reg
```
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SOFTWARE\GNU]

[HKEY_LOCAL_MACHINE\SOFTWARE\GNU\EMACS]
"HOME"="C:\\emacs-win\\"
```




### file manager
https://www.emacswiki.org/emacs/Everything
https://github.com/emacs-tw/awesome-emacs#project-management
https://github.com/sabof/project-explorer

### org-mode
https://orgmode.org/worg/org-tutorials/org4beginners.html

p.s. alternativeto org-mode [ZimWiki]


### emacs-shell windows-GIT-bash (or Babun-Shell)

在~/.emacs.d/init.el中配置如下：
```
(setq explicit-shell-file-name
      "C:/Program Files (x86)/Git/bin/bash.exe")
(setq shell-file-name explicit-shell-file-name)
(add-to-list 'exec-path "C:/Program Files (x86)/Git/bin")
```
然后在环境变量中系统变量Path最后加上
```
C:\Program Files (x86)\Git\bin  
```
现在重新启动Emacs，运行M-x shell



### *spacemacs for programmer*
[tutorial] https://zilongshanren.com/LearnEmacs/
[spacemacs] https://emacs-china.org/t/windows-emacs/7907/37
