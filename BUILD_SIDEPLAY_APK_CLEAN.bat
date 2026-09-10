@echo off
setlocal
cd /d "%~dp0"
title SidePlay - Clean Android Rebuild
echo.
echo This resets only generated Android/build output.
echo Your cached JDK/SDK and npm packages are kept for speed.
echo.
if exist android\app\build rmdir /s /q android\app\build
if exist android\.gradle rmdir /s /q android\.gradle
if exist dist rmdir /s /q dist
call BUILD_SIDEPLAY_APK.bat
