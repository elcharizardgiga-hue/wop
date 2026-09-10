# SidePlay v0.1.4 — Windows watcher fix

## Fixed

- Fixed `EBUSY: resource busy or locked, watch '.tools/android-tools.zip'` when starting the PC app after/while using the Android builder.
- Vite now ignores Android/JDK tool caches, generated Android files, `dist`, APKs and AABs.
- The one-click Android builder now stores its JDK + Android SDK under `%LOCALAPPDATA%\SidePlay\tools` instead of inside the SidePlay project.
- Existing old `.tools` folders are harmless because Vite explicitly ignores them.

## Why it happened

The Android builder previously downloaded large toolchain archives under `SidePlay/.tools`. On Windows those ZIPs can remain exclusively locked during download/extraction. Vite's filesystem watcher walked the same folder even though none of those files belong to the web app, causing Node's watcher to throw `EBUSY` and terminate the dev server.
