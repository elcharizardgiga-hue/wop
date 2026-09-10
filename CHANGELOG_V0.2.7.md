# SidePlay v0.2.7 — experimental online background engine

## Goal
The original SidePlay goal is online YouTube playback that has a chance to survive Home/screen-off without PiP. Previous builds only guaranteed background playback for local/offline Media3 sources.

## Android WebView keep-alive experiment
- Adds `WebPlaybackKeepAliveService.java` and `WebPlaybackPlugin.java`.
- Starts a foreground media-playback keep-alive only while the embedded YouTube player is actively playing.
- Holds a partial CPU wake lock and high-performance Wi-Fi lock while active.
- Keeps the Capacitor WebView renderer at `RENDERER_PRIORITY_IMPORTANT` even when not visible.
- Enables off-screen pre-rasterization and media playback without a second user gesture.
- After Android `onPause`, `onStop`, and UI-hidden memory callbacks, SidePlay explicitly resumes the WebView/timers.
- A native pulse calls the already-created YouTube iframe player's `playVideo()` again when the user's intent is still "playing" but the iframe has been paused during a background transition.
- No Picture-in-Picture.
- The keep-alive service stops when the user explicitly pauses/stops or removes the SidePlay task.

## Existing playback
Local/offline audio still uses the Media3 `PlaybackService`; that remains the reliable path for lock-screen/background playback.

## Important
This is deliberately labeled experimental. Android can keep the renderer/process alive, but the embedded YouTube player may still impose its own hidden/background behavior.
