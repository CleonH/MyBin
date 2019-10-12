cd %cd%
@echo off
echo python SimpleInbox.py [PORT] USERNAME:PASSWORD
echo DEFAULT PORT is 8999, name:passwd is abc:abc
rem python pyScript.py [PORT] USERNAME:PASSWORD
python _SimpleInbox_https_upload.py 8999 abc:abc

pause
exit