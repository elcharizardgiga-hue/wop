# SidePlay v0.1.2 — keyless PC search

- Added a localhost Node search bridge for the Windows/PC version.
- `START_SIDEPLAY.bat` now launches the search bridge and Vite together; closing the dev process shuts both down.
- PC text search no longer needs a YouTube Data API key.
- Direct pasted YouTube links on PC now use the localhost bridge to request public oEmbed metadata for a real title/channel/thumbnail when available.
- Search strategy without an API key:
  - Android: native Capacitor `NativeYouTubePlugin` -> YouTube public search page.
  - PC: localhost Node bridge -> YouTube public search page.
  - PC fallback: Invidious `/api/v1/search` using currently documented public instances.
- Official YouTube Data API support remains optional and is still preferred when a key is supplied.
- No stream extraction, PoToken bypass, or background-playback circumvention was added.
