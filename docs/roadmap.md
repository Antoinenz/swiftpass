# Roadmap

## Phase 0 spikes (~1 week)

1. **Proton backend**: log in and decrypt one login's username, password and TOTP in a Swift test, via `pass-cli` first, then Rust core / native Swift. Record cold/warm timings.
2. **Free-account AutoFill**: DONE. Not possible, needs the paid program. See [autofill.md](autofill.md) and `spikes/autofill-signing`.
3. **Browser behaviour**: what do Safari and Chrome do with a third-party AutoFill provider on current macOS?
4. **OpenPGP library** choice for Swift.

## Milestones

| # | Milestone | Outcome |
|---|---|---|
| M0 | Spikes | Backend decision, decrypt test passing, baseline timings |
| M1 | Core + CLI-backed source | Login, sync to SQLite, in-memory search, tests |
| M2 | Menu bar UI | Pre-warmed panel, browse/search/filter, copy, TOTP, Touch ID lock |
| M3 | Hotkey fill + quiet sync | Fill into any app incl. Chrome; backoff and status states |
| M4 | macOS AutoFill extension | Safari and native apps via identity store |
| M5 | Native backend replaces `pass-cli` | No external dependency |
| M6 | Polish | Settings, onboarding, Sparkle updates, install guide, DMG |

Out of scope for now: create/edit items, browser extension, Mac App Store.
