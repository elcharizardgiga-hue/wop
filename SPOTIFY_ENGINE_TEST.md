# SidePlay v0.3.0 — Spotify MediaSession experiment

This build tests a no-cloud Android playback route. SidePlay does **not** use Spotify OAuth, a Spotify Developer client ID, Google Cloud, or a SidePlay server for this experiment.

## One-time setup on Android

1. Install/log into the official Spotify Android app.
2. Open Spotify and play any song once. You can pause it afterward.
3. Open SidePlay → Settings → **Spotify background engine**.
4. Tap **Grant notification access** and enable SidePlay.
5. Return to SidePlay and tap **Refresh**.
6. Confirm **Spotify session found**. If `PLAY_FROM_SEARCH ✓` also appears, even better.
7. Enable **Prefer Spotify for online tracks**.

## Test

1. Search normally in SidePlay.
2. Tap a song.
3. SidePlay sends `playFromSearch(title + artist)` to Spotify's active Android media session.
4. If Spotify accepts the request and reports active playback, SidePlay switches to **Spotify · background** mode and does not mount the YouTube iframe.
5. Press Home, switch apps, and lock the phone.

Spotify owns the playback session in this mode, so background/screen-off playback is handled by Spotify rather than SidePlay's WebView.

## If it falls back to YouTube

Open Settings and check the Spotify engine status. The likely causes are:

- Notification Access was not granted.
- Spotify is not installed/logged in.
- Spotify has no active media session yet; open it and play anything once.
- The installed Spotify build does not honor Android `playFromSearch` on its media session.

The last case is why this feature is marked experimental.
