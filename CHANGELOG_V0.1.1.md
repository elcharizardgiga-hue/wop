# SidePlay v0.1.1

## Fixed
- Pause no longer recreates the YouTube iframe and accidentally starts playback again.
- Player state now follows YouTube PLAYING/PAUSED/ENDED events instead of assuming playback state.

## Added
- Keyless YouTube text search in the Android APK through a native Capacitor bridge.
- The native search bridge reads YouTube's public search results page on-device and extracts video result metadata locally.
- Pasted YouTube links get title/channel/thumbnail via YouTube oEmbed when no API key is configured.

## Changed
- YouTube Data API key is optional on Android. If supplied, it remains the preferred official search provider.
- Browser/Vite preview cannot use the Android native bridge, so text search there still needs an API key; direct YouTube links continue to work.
