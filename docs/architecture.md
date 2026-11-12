# Architecture

## Why existing tools are slow

Existing menu bar tools for Proton Pass wrap the official [`pass-cli`](https://github.com/ProtonPass/pass-cli). The likely cause of 2-3 s fills and noisy sync errors is a subprocess per operation (inferred, not yet profiled). SwiftPass instead keeps **one long-lived process holding an unlocked in-memory index**.

## Process model

- **SwiftPass.app** (menu bar, `LSUIElement`): owns the unlocked vault, the sync engine and the search index.
- **AutofillExtension** (`ASCredentialProviderViewController`): thin client. Reads from a shared store and asks the app over XPC when it needs a secret.
- The extension never syncs or holds long-lived secrets.

## Repository layout (planned)

```
Packages/SwiftPassCore/   Models, VaultSource protocol, crypto, store (SQLite/GRDB), search index, TOTP, sync
App/                      SwiftUI + AppKit menu bar app, hotkey, settings
AutofillExtension/        macOS AutoFill credential provider
Tests/  Benchmarks/
docs/
```

## Storage

- SQLite in an App Group container (needed so the extension can read it).
- Item blobs encrypted at rest. The key lives in the Keychain behind user presence/biometry.
- A separate small metadata table (title, domain, username) feeds `ASCredentialIdentityStore` so system AutoFill can list entries without a full unlock.

## Search index

In-memory, built at unlock: tokenised title/username/domains, prefix + fuzzy matching, ranked by exact domain match, then recency and frequency. Rebuilt incrementally after sync.

## Unlock

Touch ID / Apple Watch via a Keychain item with `.userPresence`, master password fallback, auto-lock on sleep/idle. Keys and index are zeroed on lock.

## Talking to Proton (`VaultSource` protocol)

| Option | Pros | Cons |
|---|---|---|
| A. Wrap `pass-cli` | Easy, supported by Proton | Slow, depends on their CLI, subprocess failures |
| B. Native Swift client (SRP login, 2FA, key unlock, PGP decrypt) | Fastest, fully ours | Undocumented API, real crypto work, API may change |
| C. Embed Proton's open-source Rust core via UniFFI | Reuses their crypto and models | Build complexity, need to confirm what is public |

Plan: define `VaultSource`, ship v0 on A to prove the UX, spike C then B, replace A with whichever works. A remains as a fallback. Respect Proton's ToS and rate limits.
