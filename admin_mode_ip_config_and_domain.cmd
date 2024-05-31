@echo off
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0""", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

REM Prompt the user for network configuration details
set /p INTERFACE_NAME="Enter the interface name (e.g., Ethernet): "
set /p STATIC_IP="Enter the static IP address (e.g., 192.168.1.100): "
set /p SUBNET_MASK="Enter the subnet mask (e.g., 255.255.255.0): "
set /p GATEWAY="Enter the default gateway (e.g., 192.168.1.1): "
set /p DNS_PRIMARY="Enter the primary DNS server (e.g., 8.8.8.8): "
set /p DNS_SECONDARY="Enter the secondary DNS server (e.g., 8.8.4.4): "
set /p DOMAIN_NAME="Enter the domain name (e.g., example.com): "

REM Configure the static IP address, subnet mask, and default gateway
netsh interface ip set address name="%INTERFACE_NAME%" static %STATIC_IP% %SUBNET_MASK% %GATEWAY%

REM Configure the primary DNS server
netsh interface ip set dns name="%INTERFACE_NAME%" static %DNS_PRIMARY%

REM Configure the secondary DNS server
netsh interface ip add dns name="%INTERFACE_NAME%" %DNS_SECONDARY% index=2

REM Configure the domain name
netsh interface ip set dnsservers name="%INTERFACE_NAME%" source=static addr=%DOMAIN_NAME%

REM Display the new settings
ipconfig /all

echo Network configuration has been updated.
pause