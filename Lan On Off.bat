@echo off
:MENU
echo.
echo 1. Disable LAN Connection
echo 2. Enable LAN Connection
echo 3. Exit
echo.
set /p choice=Enter your choice: 

if %choice%==1 goto disable
if %choice%==2 goto enable
if %choice%==3 exit

:disable
netsh interface set interface "Ethernet" admin=disable
echo LAN connection disabled.
pause
goto MENU

:enable
netsh interface set interface "Ethernet" admin=enable
echo LAN connection enabled.
pause
goto MENU
