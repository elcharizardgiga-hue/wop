# SidePlay v0.2.5 — Builder repair + quality-of-life

## Build reliability
- Fixed the stale `usableOffline` compile regression by basing this release on the corrected background-handoff source.
- Added `jszip` to the actual dependency set used for Google Takeout ZIP imports.
- APK builder now hashes the dependency declarations in `package.json`; when dependencies change between SidePlay versions it runs `npm install --prefer-offline` once instead of incorrectly assuming the old node_modules cache is complete.
- Explicit required-module checks catch a missing `jszip`, Capacitor CLI/App, React, or Vite install.
- Builder version is read dynamically from `package.json` so logs no longer claim v0.2.2 while compiling a newer app.

## UI / UX
- Recent YouTube searches persist locally and appear as tappable search chips.
- `Ctrl/Cmd + K` jumps to Search from anywhere on desktop.
- Desktop playback shortcuts: Space/K play-pause, J/Left -10s, L/Right +10s, Shift+N next, Shift+P previous, Escape dismisses Now Playing.
- Home now has **Surprise me**.
- Home shows a **Ready without signal** shelf when offline copies exist.
- Library history can be cleared directly and has a proper empty state.
- Settings documents keyboard shortcuts.

## Smart mixes
- **No Signal Mix** automatically groups offline-ready tracks.
- **Rediscover** surfaces liked tracks with lower play counts so old favorites do not disappear forever.
