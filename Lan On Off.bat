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
echo Attempting to disable LAN connection...
netsh interface set interface "Ethernet" admin=disable
if %errorlevel% neq 0 (
    echo Failed to disable LAN connection. Please check if the network interface name is correct.
) else (
    echo LAN connection disabled.
)
pause
goto MENU

:enable
echo Attempting to enable LAN connection...
netsh interface set interface "Ethernet" admin=enable
if %errorlevel% neq 0 (
    echo Failed to enable LAN connection. Please check if the network interface name is correct.
) else (
    echo LAN connection enabled.
)
pause
goto MENU
