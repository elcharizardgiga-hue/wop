@echo off
setlocal
cd /d "%~dp0"
title SidePlay
where node >nul 2>nul
if errorlevel 1 (
  echo Node.js 22+ is required.
  echo Install Node.js, then run this file again.
  pause
  exit /b 1
)
if not exist node_modules (
  echo Installing SidePlay dependencies...
  call npm install
  if errorlevel 1 (
    echo.
    echo npm install failed.
    pause
    exit /b 1
  )
)
echo.
echo Starting SidePlay with PC keyless YouTube search...
echo Search bridge: http://127.0.0.1:4783
echo App: Vite will print the local URL below.
echo.
call npm run dev
