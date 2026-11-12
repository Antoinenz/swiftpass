# UI

Mirrors the Proton Pass Chrome extension.

## Menu bar panel

- `NSStatusItem` plus a **pre-created, never-deallocated `NSPanel`** (borderless, vibrancy), so opening is just `orderFront`. Opens from the icon or a global hotkey (configurable). Target: visible and typeable in ≤50 ms.
- Top to bottom: search field (focused instantly) · vault picker · type chips (All, Logins, Aliases, Cards, Notes, Identities) · list (favicon, title, username, hover actions: copy user, copy password, fill) · footer (sync state, lock, settings).
- Detail view: all fields, reveal password, TOTP with countdown ring, notes, custom fields, open URL.
- "Suggested for this site/app" section on top, derived from the frontmost app or Safari tab.
- Favicons from a local cache, prefetched in the background, letter-avatar fallback so the list never flickers.
- List backed by a virtualised view with diffed updates. No per-row network or decryption.

## Keyboard

| Key | Action |
|---|---|
| ↑ ↓ | Move selection |
| ↩ | Fill or copy primary |
| ⌘C / ⇧⌘C | Copy password / username |
| ⌘T | Copy TOTP |
| ⌘O | Open site |
| ⎋ | Close |

Read-only in v1: no create or edit.
