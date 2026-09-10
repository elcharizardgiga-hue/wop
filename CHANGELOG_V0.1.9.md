# SidePlay v0.1.9 — OAuth diagnostics/fix

- Fixed the misleading `YouTube connection was cancelled` error path. SidePlay now lets Google Play Services parse any returned authorization Intent first, even when Android reports `RESULT_CANCELED`.
- Google `ApiException` status codes are surfaced in the UI. Status 10 is explained as an Android OAuth package/signing-certificate mismatch instead of being mislabeled as user cancellation.
- The APK builder now inspects the finished APK signing certificate and writes `SIDEPLAY_OAUTH_INFO.txt` with the exact Android package and SHA-1 required by Google Cloud OAuth credentials.
- Added `SHOW_SIDEPLAY_OAUTH_INFO.bat` so the OAuth identity can be reprinted without rebuilding the app.
- YouTube authorization remains read-only (`youtube.readonly`).
