# SidePlay v0.1.7 — keyless search repair

## Fixed

- Keyless search no longer relies on `ytInitialData` HTML scraping as its primary path.
- PC and Android now try YouTube's signed-out InnerTube JSON search endpoint first.
- The current WEB client version is bootstrapped from YouTube when available.
- The old HTML parser remains only as a fallback and now requires a real `ytInitialData = { ... }` assignment instead of jumping to the next `{` in the document.
- Fallback JSON candidates are validated before parsing as search state, preventing errors such as parsing `{window.ytcsi.tick(...)}` as JSON.
- PC still retains the Invidious fallback after InnerTube and HTML parsing.

## Search order

PC: InnerTube -> validated YouTube HTML -> Invidious

Android: InnerTube -> validated YouTube HTML
