@echo off
setlocal EnableExtensions
cd /d "%~dp0"
title SidePlay Doctor

echo ========================================
echo          SidePlay Doctor
echo ========================================
echo.
where node >nul 2>&1 || (echo [FAIL] Node.js is not in PATH.& goto :done)
where npm >nul 2>&1 || (echo [FAIL] npm is not in PATH.& goto :done)
for /f "delims=" %%V in ('node -p "process.versions.node"') do echo [ OK ] Node %%V
for /f "delims=" %%V in ('node -p "require('./package.json').version"') do echo [ OK ] SidePlay %%V

echo.
echo Checking native Android background engine...
for %%F in (PlaybackService.java BackgroundAudioPlugin.java SharedTextPlugin.java NativeYouTubePlugin.java DirectDownloadPlugin.java OfflineMediaPlugin.java) do (
  if exist "native\android\%%F" (echo [ OK ] %%F) else (echo [MISS] native\android\%%F)
)

echo.
echo Checking dependencies...
for %%D in ("@capacitor\cli" "@capacitor\app" "react" "vite" "jszip") do (
  if exist "node_modules\%%~D\package.json" (echo [ OK ] %%~D) else (echo [MISS] %%~D)
)

echo.
if exist "node_modules\jszip\package.json" (
  echo Running TypeScript check...
  call npm run build
  if errorlevel 1 (echo.& echo [FAIL] Web build/check failed.) else (echo.& echo [ OK ] Web build completed.)
) else (
  echo [INFO] Dependencies are incomplete. Run BUILD_SIDEPLAY_APK.bat once;
  echo        the v0.2.5 builder will sync missing packages automatically.
)

:done
echo.
pause
