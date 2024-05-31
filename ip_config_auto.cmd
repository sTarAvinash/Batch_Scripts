@echo off
REM Check if running as administrator
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo This script requires administrator privileges.
    pause
    exit /b
)

REM Prompt the user for network configuration details
set /p INTERFACE_NAME="Enter the interface name (e.g., Ethernet): "
set /p STATIC_IP="Enter the static IP address (e.g., 192.168.1.100): "
set /p SUBNET_MASK="Enter the subnet mask (e.g., 255.255.255.0): "
set /p GATEWAY="Enter the default gateway (e.g., 192.168.1.1): "
set /p DNS_PRIMARY="Enter the primary DNS server (e.g., 8.8.8.8): "
set /p DNS_SECONDARY="Enter the secondary DNS server (e.g., 8.8.4.4): "

REM Configure the static IP address, subnet mask, and default gateway
netsh interface ip set address name="%INTERFACE_NAME%" static %STATIC_IP% %SUBNET_MASK% %GATEWAY%

REM Configure the primary DNS server
netsh interface ip set dns name="%INTERFACE_NAME%" static %DNS_PRIMARY%

REM Configure the secondary DNS server
netsh interface ip add dns name="%INTERFACE_NAME%" %DNS_SECONDARY% index=2

REM Display the new settings
ipconfig /all

echo Network configuration has been updated.
pause
