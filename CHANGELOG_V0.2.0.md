# SidePlay v0.2.0

## UI / UX
- Full Senlie POS **Atardecer** visual-system port.
- Home is now the default screen.
- Desktop side rail + mobile bottom navigation.
- Rebuilt Home, Search, Library, Queue, Offline, Settings and Now Playing surfaces.
- Warmer surface hierarchy, rose/amber semantic accents, large-radius cards, two-layer elevation and native-feeling motion.

## Recommendations
- Added local Daily Mix, Liked Songs Radio, Playlist Blend and Your Rotation.
- Added Quick Picks and “Because you played…” discovery.
- Recommendation seeds use play counts, recent history, favorites, playlist membership and connected YouTube subscription names.

## Offline
- Added persistent per-track offline-copy metadata.
- Added Android `OfflineMedia` native plugin using the system document picker and a private SidePlay audio vault.
- Added PC offline vault under `%LOCALAPPDATA%\SidePlay\offline`.
- PC bridge now supports media Range requests for seeking.
- Added automatic “Prefer offline copies” playback selection.
- Android offline playback is handed to Media3/ExoPlayer for background + screen-off playback.
- Added offline playback-state events so SidePlay can advance after a local track ends while the Activity is alive.
- Added Offline tab, replace/delete copy controls and storage-size display.

## Existing functionality retained
- v0.1.7 keyless-search fixes.
- v0.1.9 OAuth error reporting + APK SHA-1 helper.
- Fast cached Android builder.
- Favorites, playlists, history, queue, shuffle/repeat, sleep timer.

## Boundary
No YouTube stream extraction, Premium-download decryption, PoToken bypass or arbitrary YouTube ripping is included.
