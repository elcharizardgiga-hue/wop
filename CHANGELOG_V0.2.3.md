# SidePlay v0.2.3 — Android background playback hardening

- Hardens native offline/direct playback with ExoPlayer wake mode, audio focus, and noisy-output handling.
- Adds `WAKE_LOCK` permission required by ExoPlayer wake mode.
- Adds start-position support to the native Media3 bridge.
- On Android, if the currently playing YouTube track has an imported offline copy, leaving the app automatically hands playback to Media3 at approximately the same position.
- The automatic handoff does not require "Prefer offline copies" to be enabled.
- Makes playback capability explicit in the UI: Background ready / Background available / YouTube foreground only.
- Does not attempt to bypass YouTube embedded-player background restrictions; online YouTube playback remains foreground-only unless a local permitted copy is available.
