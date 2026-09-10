# SidePlay v0.2.9 — Compact PiP experiment

- Adds Android Picture-in-Picture support to the Capacitor MainActivity.
- Android 12+ uses `setAutoEnterEnabled(true)` while online YouTube playback is active.
- Android 8–11 enters PiP from `onUserLeaveHint()` while playback is active.
- PiP uses a 16:9 aspect ratio and seamless resizing on Android 12+.
- When PiP is active, SidePlay hides all app chrome and promotes the existing YouTube iframe to fill the PiP window.
- Returning to SidePlay restores the Atardecer interface automatically.
- Existing WebView keep-alive foreground service remains enabled during online playback.
- PiP is intentionally visible/system-managed; Android does not provide a supported zero-size or fully hidden PiP mode. Users can stash PiP to the screen edge on supported Android versions.
- Screen-off/lock playback remains experimental because the YouTube iframe may still pause once the display is off.
