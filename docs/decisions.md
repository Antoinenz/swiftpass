# Decisions

## Made

| # | Decision | Reason |
|---|---|---|
| 1 | **Direct distribution**, no Mac App Store | Owner has no paid Apple Developer account. See the signing caveat in [autofill.md](autofill.md). |
| 2 | **Minimum macOS 13 (Ventura)**, subject to what builds cleanly | Avoid excluding older hardware needlessly. 13 gives `MenuBarExtra`-era SwiftUI and the AutoFill credential provider API (macOS 12+). Revisit once the spikes show real API needs. |
| 3 | **"Autofill" means macOS system AutoFill** (QuickType/AutoFill in Safari and native apps), not a browser extension | Proton Pass already ships a browser extension. Main browsers: Safari/WebKit; Chrome for work/school. |
| 4 | **Read-only v1** | Smaller attack surface, simpler sync. |
| 5 | **Open source from day one**, MIT, public repo | |
| 6 | **Hotkey fill is the autofill for v1; no system AutoFill extension** (2026-11-12) | Extension needs the paid Apple Developer Program. Revisit if an account is acquired. See [autofill.md](autofill.md). |

## Consequences for the plan

- The Chromium/Firefox browser extension + native messaging host is **dropped from the core roadmap** (optional, much later). Chrome is covered by the global-hotkey fill instead.
- Hotkey fill is the autofill path for every app and browser. The system AutoFill extension is deferred until a paid developer account exists.

## Open questions

- Which Proton backend: wrap `pass-cli`, embed Proton's Rust core, or a native Swift client? See [architecture.md](architecture.md).
