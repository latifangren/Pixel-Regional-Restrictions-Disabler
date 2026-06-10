@echo off
setlocal EnableExtensions EnableDelayedExpansion

set "ADB=adb"
set "LOGFILE=%~dp0adb-disable-module-race.log"
set "FOUND_ANY=0"

echo ================================================== > "%LOGFILE%"
echo adb-disable-module-race started at %date% %time% >> "%LOGFILE%"
echo Module IDs: BypassRegionalPixelLatif, BypassRegionalPixel >> "%LOGFILE%"
echo ================================================== >> "%LOGFILE%"

echo.
echo [INFO] Waiting for device and attempting module cleanup...
echo [INFO] This script is intended for rescue situations when Android can boot,
echo [INFO] ADB is already authorized, and `su` is available temporarily.
echo [INFO] Log file : %LOGFILE%
echo [INFO] Press Ctrl+C to stop.
echo.

:loop
echo [%date% %time%] Waiting for adb device...
%ADB% wait-for-device >nul 2>&1

set "ADB_STATE="
for /f "delims=" %%A in ('%ADB% get-state 2^>nul') do set "ADB_STATE=%%A"
echo [%date% %time%] adb state: !ADB_STATE!
echo [%date% %time%] adb state: !ADB_STATE!>> "%LOGFILE%"

set "BOOT_STATE="
for /f "delims=" %%A in ('%ADB% shell getprop sys.boot_completed 2^>nul') do set "BOOT_STATE=%%A"
echo [%date% %time%] sys.boot_completed: !BOOT_STATE!
echo [%date% %time%] sys.boot_completed: !BOOT_STATE!>> "%LOGFILE%"

echo [%date% %time%] Trying root shell...
echo [%date% %time%] Trying root shell...>> "%LOGFILE%"
%ADB% shell su -c id >> "%LOGFILE%" 2>&1
%ADB% shell su -c id >nul 2>&1
if errorlevel 1 (
  echo [WARN] Root shell not ready yet.
  echo [%date% %time%] Root shell not ready yet.>> "%LOGFILE%"
  goto :sleep
) else (
  echo [ OK ] Root shell is available.
)

set "FOUND_ANY=0"

call :tryPath "/data/adb/modules/BypassRegionalPixelLatif"
call :tryPath "/data/adb/modules_update/BypassRegionalPixelLatif"
call :tryPath "/data/adb/ksu/modules/BypassRegionalPixelLatif"
call :tryPath "/data/adb/ksu/modules_update/BypassRegionalPixelLatif"
call :tryPath "/data/adb/modules/BypassRegionalPixel"
call :tryPath "/data/adb/modules_update/BypassRegionalPixel"
call :tryPath "/data/adb/ksu/modules/BypassRegionalPixel"
call :tryPath "/data/adb/ksu/modules_update/BypassRegionalPixel"

if "!FOUND_ANY!"=="1" (
  echo.
  echo [DONE] At least one matching module path was found and cleanup was attempted.
  echo [DONE] Check %LOGFILE% for details, then reboot the device.
  goto :eof
) else (
  echo [INFO] No matching module path found in this cycle.
)

:sleep
echo [%date% %time%] Cycle done. Sleeping 2 seconds...
echo [%date% %time%] Cycle done. Sleeping 2 seconds...>> "%LOGFILE%"
timeout /t 2 /nobreak >nul
goto :loop

:tryPath
set "TARGET=%~1"
echo [%date% %time%] Trying !TARGET!
echo [%date% %time%] Trying !TARGET!>> "%LOGFILE%"

%ADB% shell su -c "ls -ld !TARGET!" >> "%LOGFILE%" 2>&1
%ADB% shell su -c "test -d !TARGET!" >nul 2>&1
if errorlevel 1 (
  echo [MISS] !TARGET!
  echo [%date% %time%] Missing !TARGET!>> "%LOGFILE%"
  goto :eof
)

set "FOUND_ANY=1"
echo [FOUND] !TARGET!
echo [%date% %time%] Found !TARGET!>> "%LOGFILE%"
%ADB% shell su -c "touch !TARGET!/disable" >> "%LOGFILE%" 2>&1
%ADB% shell su -c "touch !TARGET!/remove" >> "%LOGFILE%" 2>&1
%ADB% shell su -c "rm -rf !TARGET!" >> "%LOGFILE%" 2>&1
%ADB% shell su -c "sync" >> "%LOGFILE%" 2>&1
echo [CLEAN] Cleanup attempted for !TARGET!
echo [%date% %time%] Cleanup attempted for !TARGET!>> "%LOGFILE%"

goto :eof
