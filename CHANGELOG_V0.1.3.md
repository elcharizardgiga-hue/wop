# SidePlay v0.1.3 — Queue semantics fix

- Tapping a search result now **plays only that track**. Search results are no longer silently converted into a queue.
- The Queue tab now means **Up Next**. The currently playing track and already-played session items are hidden from it.
- Queue badge counts only tracks that are actually waiting to play.
- **Clear queue** clears Up Next without stopping the current song.
- **Add to queue** and **Play next** no longer auto-start playback when nothing is currently playing.
- Previous/Next compatibility is preserved by retaining the internal session list while presenting a clean Up Next queue in the UI.
