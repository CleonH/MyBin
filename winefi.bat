@echo off
Title ESP分区挂载管理1.1.3 by 若水
mode con lines=40 cols=90
color 0a
echo.

:: 批处理获取管理员权限
:-------------------------------------  
REM  --> 检查权限 
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"  
  
REM --> 如果出现错误标志，说明没有权限
if '%errorlevel%' NEQ '0' (
	echo       未使用管理员权限运行，请求管理员权限……
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
  
    cscript /nologo "%temp%\getadmin.vbs"
    exit /B
	del "%temp%\getadmin.vbs"
)
    pushd "%CD%"
    CD /D "%~dp0"
:-------------------------------------- 

:MENU
cls
echo.
echo         ESP分区挂载管理1.1.3 by 若水（win7、win8、win10）
echo                                              2017.1.7
echo.   ┏━━━━━━━━━━━━━━━━━━━━━━━━━━┓
echo                 1、 挂载 分区
echo.
echo                 2、 卸载 分区
echo.
echo                 3、 查看 分区挂载状态
echo.
echo.                4.  资源管理器 管理员权限打开(管理ESP分区)
echo.
echo                 e、 退出
echo.   ┗━━━━━━━━━━━━━━━━━━━━━━━━━━┛
set choice=1
set /p choice=         请选择要进行的操作(默认为：%choice%)，然后按回车: 
if /i "%choice%"=="1" goto mount
if /i "%choice%"=="2" goto unmount
if /i "%choice%"=="3" goto view
if /i "%choice%"=="4" goto viewesp
if /i "%choice%"=="e" goto EX

:mount
cls
echo.
echo                   挂载分区

echo.
set d=0
set p=1
set m=S
echo list disk|diskpart.exe
set /p d=请输入选择的磁盘编号,默认为选择磁盘 0：
cmd /c "echo select disk %d% & echo list partition"|diskpart.exe

cls
echo.
cmd /c "echo select disk %d% & echo list volum & echo list partition"|diskpart.exe
set /p p=请输入选择的分区编号，默认为选择分区 1：

cls
echo.
cmd /c "echo select disk %d% & echo list volum & echo list partition"|diskpart.exe
echo           为磁盘 %d% 的分区 %p% 指定盘符
echo.
set /p m=请输入挂载盘符,默认挂载为 S 盘：

cls
cmd /c "echo select disk %d% & echo select partition %p% & echo assign letter=%m% & echo list volum & echo exit"|diskpart.exe
pause
goto MENU

:unmount
cls
echo.
echo                   卸载分区
set m=S
echo list volum|diskpart.exe
set /p m=请输入要卸载的盘符，默认卸载 S 盘：
cmd /c "echo select volume %m% & echo remove letter=%m% & echo exit"|diskpart.exe
pause
goto MENU

:view
cls
echo.
echo                  查看已挂载分区
echo list volum|diskpart.exe
pause
goto MENU

:viewesp
set inf=%temp%\hisecws.inf
set reg_runas=CLASSES_ROOT\AppID\{CDCBCFCA-3CDC-436f-A4E2-0E02075250C2}
reg query HKEY_%reg_runas% /v "RunAs">nul
if %errorlevel% ==0 (
	(
		echo [Version]
		echo Signature = "$Windows NT$"
		echo [Registry Keys]
		echo "%reg_runas%", 0, "O:BA"
	)>%inf%
	secedit /configure /db %temp%\hisecws.sdb /cfg %inf% /log %temp%\hisecws.log
	
	echo HKEY_%reg_runas% [1 7 17]>%inf%
	regini %inf%
	reg delete HKEY_%reg_runas% /v "RunAs"  /f
	
	explorer.exe ,::{20D04FE0-3AEA-1069-A2D8-08002B30309D}
		
	reg add    HKEY_%reg_runas% /v "RunAs" /t REG_SZ /d "Interactive User"
	echo HKEY_%reg_runas% [2 8 19]>%inf%
	regini %inf%
	
	FOR /F "usebackq tokens=2 delims=:" %%i in (`sc showsid TrustedInstaller`) do (
		(
			echo [Version]
			echo Signature = "$Windows NT$"
			echo [Registry Keys]
			echo "%reg_runas%", 0, "O:%%i"
		)>%inf%
	)
	secedit /configure /db %temp%\hisecws.sdb /cfg %inf% /log %temp%\hisecws.log
	del /s /q /f %inf%
)
goto MENU

:ex
exit
