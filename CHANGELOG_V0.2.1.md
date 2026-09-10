# SidePlay v0.2.1

- Offline replacement is now atomic: cancelling a replacement no longer deletes the existing copy.
- PC offline imports stream to disk instead of buffering the entire file in memory.
- Browser file-picker cancellation is handled more reliably.
- Offline UI now says “Import offline audio” instead of pretending local import is a download.
- Direct file downloads are a separate feature from Offline Library.
- PC direct downloads now use the local SidePlay bridge instead of a cross-origin browser anchor.
- YouTube account errors now explicitly identify a disabled YouTube Data API v3 service.
- Settings clarify that OAuth account import requires the Data API to be enabled, but does not require an API key.
