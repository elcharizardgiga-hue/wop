# SidePlay v0.2.8 — Android compile repair

- Fixed generated `MainActivity.onDestroy()` visibility for Capacitor 8. `BridgeActivity.onDestroy()` is public, so SidePlay now overrides it as public instead of protected.
- Audited the other generated lifecycle overrides against Capacitor 8: `onResume`, `onPause`, `onStop`, and `onTrimMemory` remain public; `onActivityResult` and `onNewIntent` remain protected.
- Keeps the v0.2.7 experimental WebView background engine unchanged otherwise.
- The deprecation warning in `WebPlaybackKeepAliveService` is non-fatal and does not block compilation.
