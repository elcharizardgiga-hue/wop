# SidePlay v0.2.6 — Native background playback repair

This release fixes a packaging regression and changes how Android chooses its playback engine.

## Critical repair

- Restores the complete `native/android/` source tree to the release ZIP. v0.2.4/v0.2.5 packages accidentally shipped an empty native folder while `patch-android.mjs` still referenced those Java files.
- The Android builder now performs a native-source preflight before doing any expensive work and fails immediately with the missing filename if a release is incomplete.
- `SIDEPLAY_DOCTOR.bat` also reports the presence of every required native source file.

## Background playback

- Android no longer waits for `appStateChange` to start Media3.
- If the current track has a valid Android offline copy, SidePlay uses the native Media3 player immediately from the user's Play action while the Activity is still foregrounded.
- `PlaybackService.onStartCommand()` now calls `super.onStartCommand(...)` as required by `MediaSessionService`.
- The playback service is explicitly `android:stopWithTask="false"` and keeps active playback alive when the task is dismissed.
- ExoPlayer continues to use media audio focus, noisy-headphone handling, and a local wake mode.
- Native player failures are surfaced back to the SidePlay UI instead of silently appearing as a pause.
- Importing an offline copy for the song currently playing can transition to native playback around the current position instead of deliberately restarting from zero.

## UX

- On Android the Offline screen now shows **Android native playback — AUTO** instead of a misleading preference toggle.
- The desktop-only “Prefer offline copies” option remains available on PC.
- Existing queue, recommendations, Atardecer UI, keyless search, Takeout import, and offline vault behavior are preserved.

Online YouTube iframe playback remains a foreground playback source. The native background engine is used for SidePlay-controlled local/direct media sources.
