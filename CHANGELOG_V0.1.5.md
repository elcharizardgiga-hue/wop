# SidePlay v0.1.5

## Windows watcher fix, actually this time

- Replaced Vite/Chokidar glob-based watcher ignores with a function-based path filter.
- Normalizes Windows `\\` paths before filtering.
- Excludes legacy `.tools`, generated `android`, `dist`, APK and AAB outputs from Vite's watcher.
- PC launcher now makes a best-effort removal of the obsolete in-project `.tools` cache before Vite starts.
- If Windows or antivirus still has a legacy tool archive locked, startup continues because the watcher excludes that directory.
- Android SDK/JDK downloads remain stored outside the source tree under `%LOCALAPPDATA%\\SidePlay\\tools`.
