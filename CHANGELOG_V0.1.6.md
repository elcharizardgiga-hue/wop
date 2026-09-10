# SidePlay v0.1.6 — APK builder repair + fast rebuilds

- Reworked `BUILD_SIDEPLAY_APK.bat` into a checked, logged build pipeline.
- Writes `sideplay-build.log` and prints the last useful log lines when a stage fails.
- Repeat builds use `npx cap copy android` instead of a full Capacitor sync.
- JDK, Android command-line tools, platform 36, build-tools 36 and accepted licenses are cached under `%LOCALAPPDATA%\SidePlay\tools`.
- `sdkmanager` is skipped completely when the required SDK files already exist.
- Downloads use `curl.exe` with retry when available, falling back to PowerShell.
- Gradle uses the daemon and build cache for incremental repeat builds.
- Added `BUILD_SIDEPLAY_APK_CLEAN.bat` for a clean Android rebuild without deleting the heavyweight SDK/JDK cache.
- Final APK existence is validated before reporting success.
