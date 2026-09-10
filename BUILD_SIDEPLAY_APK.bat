@echo off
setlocal EnableExtensions EnableDelayedExpansion
cd /d "%~dp0"
title SidePlay - Fast Android Builder

set "SIDEPLAY_TOOLS=%LOCALAPPDATA%\SidePlay\tools"
if "%LOCALAPPDATA%"=="" set "SIDEPLAY_TOOLS=%USERPROFILE%\AppData\Local\SidePlay\tools"
set "LOG=%CD%\sideplay-build.log"
set "ERRMSG=Unknown build error."
set "NEED_NPM=1"

where node >nul 2>&1
if errorlevel 1 (
  set "ERRMSG=Node.js 22+ was not found in PATH."
  goto :fail_early
)
where npm >nul 2>&1
if errorlevel 1 (
  set "ERRMSG=npm was not found in PATH."
  goto :fail_early
)

for /f "delims=" %%V in ('node -p "require('./package.json').version"') do set "APPVER=%%V"
if "%APPVER%"=="" set "APPVER=unknown"
>"%LOG%" echo SidePlay Android Build v%APPVER% - %DATE% %TIME%

echo SidePlay Android Builder v%APPVER%
echo Fast repeat builds + dependency-aware cache
echo Log: %LOG%
echo.

for /f "delims=" %%V in ('node -p "process.versions.node"') do set "NODEVER=%%V"
echo Node %NODEVER%
echo [%TIME%] Node %NODEVER%>>"%LOG%"

echo Checking native Android sources...
for %%F in (PlaybackService.java BackgroundAudioPlugin.java SharedTextPlugin.java NativeYouTubePlugin.java DirectDownloadPlugin.java OfflineMediaPlugin.java WebPlaybackKeepAliveService.java WebPlaybackPlugin.java SpotifySessionListenerService.java SpotifySessionPlugin.java) do (
  if not exist "native\android\%%F" (
    set "ERRMSG=Release is incomplete: native\android\%%F is missing."
    goto :fail
  )
)
echo [ OK ] Native background playback sources present.
echo [%TIME%] native source preflight OK>>"%LOG%"

rem ---------------------------------------------------------------------------
rem [1/7] Dependency cache validation.
rem Old SidePlay builds only checked for Capacitor, so a new dependency such as
rem jszip could be missing while the builder incorrectly printed "npm cache ready".
rem We hash only dependency declarations (not the app version) and also check the
rem important runtime/build packages. Version-only updates therefore stay fast.
rem ---------------------------------------------------------------------------
for /f "delims=" %%H in ('node -e "const p=require('./package.json'),c=require('crypto'); console.log(c.createHash('sha256').update(JSON.stringify([p.dependencies,p.devDependencies])).digest('hex'))"') do set "PKGHASH=%%H"
set "HASHFILE=node_modules\.sideplay-package.sha256"
set "CACHEDHASH="
if exist "%HASHFILE%" set /p CACHEDHASH=<"%HASHFILE%"

if /I "%PKGHASH%"=="%CACHEDHASH%" set "NEED_NPM=0"
if not exist node_modules\@capacitor\cli\package.json set "NEED_NPM=1"
if not exist node_modules\@capacitor\app\package.json set "NEED_NPM=1"
if not exist node_modules\react\package.json set "NEED_NPM=1"
if not exist node_modules\vite\package.json set "NEED_NPM=1"
if not exist node_modules\jszip\package.json set "NEED_NPM=1"

if "%NEED_NPM%"=="1" (
  echo [1/7] Syncing npm dependencies - package changed or cache incomplete...
  echo [%TIME%] [1/7] npm install --prefer-offline>>"%LOG%"
  call npm install --prefer-offline --no-audit --no-fund >>"%LOG%" 2>&1
  if errorlevel 1 (
    set "ERRMSG=npm dependency sync failed."
    goto :fail
  )
  if not exist node_modules mkdir node_modules >nul 2>&1
  >"%HASHFILE%" echo %PKGHASH%
) else (
  echo [1/7] npm dependencies unchanged - skip install.
  echo [%TIME%] [1/7] npm skipped; package hash matched>>"%LOG%"
)

echo [2/7] Building web app...
echo [%TIME%] [2/7] web build>>"%LOG%"
call npm run build >>"%LOG%" 2>&1
if errorlevel 1 (
  set "ERRMSG=Web build failed."
  goto :fail
)

if not exist android\gradlew.bat (
  echo [3/7] Creating Android project - first run only...
  echo [%TIME%] [3/7] cap add android>>"%LOG%"
  call npx cap add android >>"%LOG%" 2>&1
  if errorlevel 1 (
    set "ERRMSG=Capacitor could not create android/."
    goto :fail
  )
  set "NEED_SYNC=1"
) else (
  echo [3/7] Android project already exists.
  echo [%TIME%] [3/7] android exists>>"%LOG%"
  set "NEED_SYNC=0"
)

if "%NEED_SYNC%"=="1" (
  echo [4/7] Initial Capacitor sync...
  echo [%TIME%] [4/7] cap sync>>"%LOG%"
  call npx cap sync android >>"%LOG%" 2>&1
  if errorlevel 1 (
    set "ERRMSG=Capacitor sync failed."
    goto :fail
  )
) else (
  echo [4/7] Fast-copying fresh web assets...
  echo [%TIME%] [4/7] cap copy>>"%LOG%"
  call npx cap copy android >>"%LOG%" 2>&1
  if errorlevel 1 (
    set "ERRMSG=Capacitor copy failed."
    goto :fail
  )
)

echo [5/7] Patching native SidePlay bridge...
echo [%TIME%] [5/7] patch native>>"%LOG%"
call node scripts\patch-android.mjs >>"%LOG%" 2>&1
if errorlevel 1 (
  set "ERRMSG=Native Android patch failed."
  goto :fail
)

echo [6/7] Checking cached JDK + Android SDK...
echo [%TIME%] [6/7] toolchain check>>"%LOG%"
powershell -NoProfile -ExecutionPolicy Bypass -File scripts\setup-android-tools.ps1 >>"%LOG%" 2>&1
if errorlevel 1 (
  set "ERRMSG=Android toolchain setup failed."
  goto :fail
)
if not exist "%SIDEPLAY_TOOLS%\sideplay-env.bat" (
  set "ERRMSG=Toolchain environment file was not created."
  goto :fail
)
call "%SIDEPLAY_TOOLS%\sideplay-env.bat"

if not exist "%JAVA_HOME%\bin\java.exe" (
  set "ERRMSG=Cached Java executable is missing."
  goto :fail
)
if not exist "%ANDROID_HOME%\platforms\android-36\android.jar" (
  set "ERRMSG=Android SDK 36 is missing."
  goto :fail
)

echo [7/7] Gradle assembleDebug - cached incremental build...
echo [%TIME%] [7/7] gradle assembleDebug>>"%LOG%"
pushd android
call gradlew.bat --daemon --build-cache --console=plain assembleDebug >>"%LOG%" 2>&1
set "GRADLE_RC=%ERRORLEVEL%"
popd
if not "%GRADLE_RC%"=="0" (
  set "ERRMSG=Gradle compilation failed."
  goto :fail
)

set "APK=android\app\build\outputs\apk\debug\app-debug.apk"
if not exist "%APK%" (
  set "ERRMSG=Gradle finished but app-debug.apk was not found."
  goto :fail
)
copy /Y "%APK%" "SidePlay-debug.apk" >nul
if errorlevel 1 (
  set "ERRMSG=Could not copy final APK."
  goto :fail
)

for %%A in ("SidePlay-debug.apk") do set "APKSIZE=%%~zA"
echo [%TIME%] SUCCESS SidePlay-debug.apk !APKSIZE! bytes>>"%LOG%"
echo.
echo ========================================
echo   DONE: %CD%\SidePlay-debug.apk
echo ========================================
echo.
echo Repeat builds skip npm, JDK, SDK and license setup when unchanged.
echo Full details: sideplay-build.log
echo.
pause
exit /b 0

:fail_early
echo SidePlay Android Builder
echo.
echo BUILD FAILED: %ERRMSG%
echo.
pause
exit /b 1

:fail
echo.
echo BUILD FAILED: %ERRMSG%
echo [%TIME%] BUILD FAILED: %ERRMSG%>>"%LOG%"
echo.
echo Last 60 log lines:
powershell -NoProfile -Command "if (Test-Path -LiteralPath '%LOG%') { Get-Content -LiteralPath '%LOG%' -Tail 60 }"
echo.
echo Full diagnostic log:
echo %LOG%
echo.
pause
exit /b 1
