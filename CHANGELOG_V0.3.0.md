# SidePlay v0.3.0 — Spotify Session Engine

- Adds an experimental **no-cloud Spotify background engine** for Android.
- Uses Android `MediaSessionManager` / `MediaController.TransportControls` instead of Spotify OAuth or Spotify Developer credentials.
- SidePlay can request playback via `playFromSearch`, then control play/pause/next/previous/seek through Spotify's active media session.
- Adds a user-facing Notification Access setup/status card.
- Detects whether Spotify is installed, whether an active Spotify media session exists, and whether the session advertises `PLAY_FROM_SEARCH`, `PLAY_FROM_URI`, and seeking.
- YouTube remains discovery/fallback playback; local/offline audio still uses SidePlay Media3.
- Auto-PiP is disabled while the Spotify engine preference is enabled.
- Adds Spotify-session playback state/progress polling to the SidePlay player.
- The Android builder now verifies the new Spotify session native sources before building.
