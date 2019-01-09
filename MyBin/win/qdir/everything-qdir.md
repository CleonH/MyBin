
### qdir 
 在运行的实例中使用新标签打开

### Everything 

$exec("C:\opt\qdir\Q-Dir.exe" /e>$pathpart(%1))

$exec("%SystemRoot%\explorer.exe" /n,/e,"%1")
