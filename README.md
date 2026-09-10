# SidePlay v0.3.0

**New:** experimental no-cloud Spotify MediaSession engine for Android. See `SPOTIFY_ENGINE_TEST.md`. It uses user-granted Android Notification Access to control Spotify's active media session for background/screen-off playback; no Spotify Developer client ID is required for this experiment.

# SidePlay v0.2.8

## Experimental online YouTube background mode

The Android build now includes a WebView keep-alive experiment for normal online YouTube playback: foreground keep-alive service, CPU/Wi-Fi locks, high-priority WebView renderer, off-screen prerasterization, lifecycle resume, and a native playback nudge when the user still intends playback. This is **not PiP**. Local/offline files continue to use Media3 and remain the reliable background path.

SidePlay is a local-first music client built with React/Vite + Capacitor for Android. It keeps keyless public YouTube search, SidePlay playlists/favorites/history/recommendations, and local offline playback without requiring a Google Cloud project, YouTube Data API key, or OAuth client.

## Start on PC

Double-click `START_SIDEPLAY.bat`. It starts the local SidePlay bridge at `http://127.0.0.1:4783` and the Vite app. Public YouTube search is handled through that local bridge.

## Build the Android APK

Double-click `BUILD_SIDEPLAY_APK.bat`. The first build installs/caches the Android/JDK toolchain under `%LOCALAPPDATA%\SidePlay\tools`; repeat builds reuse it. The output is `SidePlay-debug.apk`. Use `BUILD_SIDEPLAY_APK_CLEAN.bat` only if generated Android state becomes corrupted.

## No Google Cloud / no OAuth

There is no Google account connection in this build. Public search stays keyless. To personalize SidePlay with your own YouTube history/library, open **Settings → YouTube library — no cloud** and import a Google Takeout export.

Recommended Takeout choice: export only **YouTube and YouTube Music**. SidePlay can read a Takeout ZIP directly, or compatible `.csv`, `.json`, `.html` files. It recognizes common exports for:

- playlists → local SidePlay playlists
- Liked Videos → SidePlay Favorites
- watch history → SidePlay history / recommendation seeds
- subscriptions → local recommendation seeds

Everything is parsed locally in the app; no Google API credentials are required. Export formats can vary by locale/version, so unsupported Takeout layouts simply skip files they do not recognize rather than overwriting your library.

## Recommendations

Home includes local smart mixes such as Daily Mix, Liked Songs Radio, Playlist Blend, Your Rotation, Quick Picks, and discovery recommendations. These use SidePlay favorites, playlists, play counts, history, imported YouTube history, and imported subscription names as seeds. They are SidePlay recommendations, not YouTube's proprietary personalized Home/My Mix feed.

## Offline playback

SidePlay can attach a local audio copy to a track. On Android the imported copy is stored in app-private storage and, whenever available for the selected track, is played through Media3 immediately from the Play action. This is the background/screen-off-capable engine. On PC it is stored under `%LOCALAPPDATA%\SidePlay\offline` and streamed by the local SidePlay bridge with byte-range support.

The Offline/Downloads UI intentionally distinguishes:

- **Import offline audio** — attach a local file you already have permission to store.
- **Direct file download** — download a real direct media URL from a source that permits it.

SidePlay does not implement a YouTube ripping/downloading bypass.

## Key files

- `src/App.tsx` — UI and playback orchestration
- `src/lib/store.tsx` — playlists, favorites, history, queue, offline mappings
- `src/lib/youtubeTakeout.ts` — local YouTube/Takeout importer
- `src/lib/recommendations.ts` — Made for You logic
- `scripts/pc-search-server.mjs` — keyless PC search + offline vault
- `native/android/NativeYouTubePlugin.java` — keyless Android search
- `native/android/PlaybackService.java` — Android Media3 service
- `scripts/patch-android.mjs` — applies SidePlay native Android plugins

## v0.2.2

- removed Google OAuth / Google Cloud requirements and UI
- removed the Google Play Services auth dependency from Android builds
- added local Google Takeout YouTube/YouTube Music import
- imported subscriptions feed Made for You recommendations
- public keyless search and offline playback remain intact

## v0.2.3 Android background playback

Android native playback is now hardened with Media3 wake mode and audio focus. Imported offline copies can continue when the screen turns off or SidePlay goes into the background. If a YouTube track is currently playing through the embedded YouTube player but that same track has an Android offline copy, SidePlay automatically hands playback to the offline Media3 service when the app leaves the foreground, preserving the approximate playback position.

Online YouTube iframe playback itself remains foreground-only. SidePlay shows the playback capability on the mini-player/Now Playing screen so this distinction is visible rather than surprising.


## v0.2.4 Smooth player / Android background hardening

The player now has real elapsed/duration state and seeking across the embedded YouTube player, PC offline audio, and Android Media3 offline/direct playback. The mini-player shows live progress and the full Now Playing sheet has an actual scrubber and timestamps.

On Android, Settings includes **Background playback health**, which can open Android battery optimization settings. If an OEM aggressively kills SidePlay's native media service, set SidePlay to Unrestricted / Not optimized. Android background-capable media still runs through `MediaSessionService`; online YouTube playback remains the embedded foreground player.

The Atardecer UX was also tightened with native-feeling page transitions, spring press feedback, an active navigation pill, smoother cards, animated album artwork, and a swipe-down handle for Now Playing.

## v0.2.5 builder note
The Android builder now validates the dependency cache against a SHA-256 of the dependency declarations in `package.json`. This fixes upgrades where an old `node_modules` folder existed but a newly-added dependency (notably `jszip`) was missing. Use `SIDEPLAY_DOCTOR.bat` for a quick dependency/web-build diagnostic without downloading the Android toolchain.

### Desktop shortcuts
- `Ctrl/Cmd + K` — Search
- `Space` or `K` — Play/pause
- `J` / Left Arrow — back 10 seconds
- `L` / Right Arrow — forward 10 seconds
- `Shift + N` — next
- `Shift + P` — previous
- `Esc` — dismiss Now Playing


## v0.2.6 critical Android fix

v0.2.4/v0.2.5 had a packaging regression: the release archive contained an empty `native/` directory even though the Android patcher expected the Java playback service/plugins there. v0.2.6 restores all native sources and adds a builder preflight so an incomplete release fails before npm/Vite/Gradle work begins.

Android also no longer waits until the app is already backgrounding to start its media foreground service. A track with an Android offline copy uses Media3 from the original Play tap, while SidePlay is foregrounded. The service explicitly survives task dismissal while playback is active, calls the `MediaSessionService` superclass bookkeeping, and reports native player errors back to the UI.


## v0.2.8 compile repair

Capacitor 8 declares `BridgeActivity.onDestroy()` as `public`. SidePlay v0.2.7 generated it as `protected`, causing `javac` to fail with “attempting to assign weaker access privileges”. v0.2.8 generates `public void onDestroy()` and keeps the experimental WebView background path otherwise unchanged.


## v0.2.9 compact PiP experiment

For online YouTube playback on Android, SidePlay can now automatically enter a stripped-down 16:9 Picture-in-Picture window when you leave the app. The PiP surface contains only the existing YouTube player; the normal Atardecer interface is hidden until you return. Android 12+ uses native auto-enter and seamless resize. On supported devices you can manually stash PiP against the screen edge. PiP is system-managed and cannot be made truly invisible. Screen-off behavior remains experimental.


## Phone-only APK build

See `MOBILE_CLOUD_BUILD.md`. This release includes a GitHub Actions builder that returns a ZIP artifact containing `SidePlay-debug.apk`.
