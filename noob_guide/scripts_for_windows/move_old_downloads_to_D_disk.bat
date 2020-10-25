@echo off

set X=14

set "source=C:\Users\chh\Downloads"

set "destination=D:\0ld_downloads"

robocopy "%source%" "%destination%" /mov /minage:%X%

exit /b