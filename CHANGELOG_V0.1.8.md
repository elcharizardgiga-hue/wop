# SidePlay v0.1.8 — YouTube account connection

- No Picture-in-Picture path added.
- Added Android YouTube OAuth using Google Play services `AuthorizationClient`.
- Requests only `youtube.readonly`.
- Connected account can load the authenticated channel, YouTube playlists, and subscriptions.
- YouTube playlists can be imported into SidePlay's local playlist library.
- OAuth access tokens are kept in memory only; SidePlay stores only lightweight account metadata locally.
- Added Disconnect, which revokes the app's read-only YouTube grant.
- Kept the existing keyless public-search bridge and local favorites/playlists/history/queue.
- Native Media3 engine remains available for authorized direct-media sources.

## Google Cloud setup required

For Android OAuth, enable **YouTube Data API v3** in a Google Cloud project and create an **Android OAuth client** for package:

`app.sideplay.mobile`

Register the SHA-1 fingerprint of the signing key used for the APK. For the debug builder this is normally the Android debug keystore fingerprint. The APK builder itself does not need your OAuth client secret.
