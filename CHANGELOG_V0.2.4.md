# SidePlay v0.2.4 — Smooth Player / Background Hardening

- Added a real playback progress model across YouTube, PC offline audio, and Android Media3.
- Added a real scrubber with elapsed / remaining time in Now Playing.
- Added mini-player progress instead of the old decorative progress bar.
- Android native Media3 bridge now exposes playback position, duration, seek, and playback-health status.
- Added Android battery/background settings shortcut for devices that aggressively optimize media apps.
- Kept MediaSessionService + wake mode + audio focus for background-capable offline/direct sources.
- Added swipe-down gesture on the Now Playing grabber to dismiss the full player.
- Added smoother Atardecer page transitions, press feedback, nav active-pill motion, card lift, and artwork play/pause motion.
- Fixed stale Atardecer CSS token names in playback-source badges.
- No PiP.
- Online YouTube remains on the embedded player; SidePlay does not add a YouTube access-control or PoToken bypass.
