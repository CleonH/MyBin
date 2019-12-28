
```
@echo off
echo 删除n天前的备分文件和日志

forfiles /p "D:\backup" /m *.dmp /d -7 /c "cmd /c del @path"
forfiles /p "D:\backup" /m *.log /d -7 /c "cmd /c del @path"

echo 正在执行逻辑备份，请稍等……
pause
echo 任务完成!
```

说明：
/p 指定的路径
/s 包括子目录
/m 查找的文件名掩码
/d 指定日期,有绝对日期和相对日期, 此处-7指当前日期 的7天前   


/c 运行的命令行  表示为每个文件执行的命令。命令字符串应该
用双引号括起来。
默认命令是 "cmd /c echo @file"。下列变量可以用在命令字符串中:
    @file    - 返回文件名。
    @fname   - 返回不带扩展名的文件名。
    @ext     - 只返回文件的扩展。
    @path    - 返回文件的完整路径。
    @relpath - 返回文件的相对路径。
    @isdir   - 如果文件类型是目录，返回 "TRUE"；
               如果是文件，返回 "FALSE"。
    @fsize   - 以字节为单位返回文件大小。
    @fdate   - 返回文件上一次修改的日期。
    @ftime   - 返回文件上一次修改的时间



```
@echo off
::演示：删除指定路径下指定天数之前（以文件的最后修改日期为准）的文件。
::如果演示结果无误，把del前面的echo去掉，即可实现真正删除。
::本例调用了临时VBS代码进行日期计算
::本例为兼容不同的日期格式，调用reg命令（XP系统自带）统一设置日期格式，
::处理完毕之后再把日期格式恢复成原来的状态。
::
rem 指定待删除文件的存放路径
set SrcDir=C:/Test/BatHome
rem 指定天数
set DaysAgo=1
for /f "skip=2 delims=" %%a in ('reg query "HKEY_CURRENT_USER/Control Panel/International" /v sShortDate') do (
    set "RegDateOld=%%a"
)
set RegDateOld=%RegDateOld:~-8%
reg add "HKEY_CURRENT_USER/Control Panel/International" /v sShortDate /t REG_SZ /d yyyy-M-d /f>nul
>"%temp%/DstDate.vbs" echo LastDate=date()-%DaysAgo%
>>"%temp%/DstDate.vbs" echo FmtDate=right(year(LastDate),4) ^& right("0" ^& month(LastDate),2) ^& right("0" ^& day(LastDate),2)
>>"%temp%/DstDate.vbs" echo wscript.echo FmtDate
for /f %%a in ('cscript /nologo "%temp%/DstDate.vbs"') do (
    set "DstDate=%%a"
)
set DstDate=%DstDate:~0,4%-%DstDate:~4,2%-%DstDate:~6,2%
for /r "%SrcDir%" %%a in (*.*) do (
    if "%%~ta" leq "%DstDate%" (
        if exist "%%a" (
            echo del /f /q "%%a"
        )
    )
)
reg add "HKEY_CURRENT_USER/Control Panel/International" /v sShortDate /t REG_SZ /d %RegDateOld% /f>nul
pause
```
