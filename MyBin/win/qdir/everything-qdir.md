$exec("C:\opt\qdir\Q-Dir.exe" /e>$pathpart(%1))
$exec("%SystemRoot%\explorer.exe" /n,/e,"%1")
