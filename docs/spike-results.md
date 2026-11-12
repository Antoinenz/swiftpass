# Phase 0 spike results

## pass-cli timings (2026-11-12, pass-cli 2.7.0, Homebrew, existing logged-in session, ~130 items in 9 vaults)

| Command | Time |
|---|---|
| `info` | 0.05 s (local) |
| `vault list --output json` | 1.4 s |
| `item list <vault>` (6 items) | 2.3 s |
| `item list <vault>` (22 items) | 2.9 s |
| `item list <vault>` (95 items, metadata only) | 3.2 s |
| `item list <vault> --show-secrets` (95 items, full decrypted content) | 3.5 s |

Findings:
- **Every call costs 2-3 s of fixed overhead** (network round trip plus session/key setup), nearly independent of vault size. Any app that shells out per search or fill will be this slow. This explains the 2-3 s autofill of existing tools and is the core reason for SwiftPass's design.
- `--show-secrets` returns full decrypted content in one call, only about 0.3 s more than metadata. So a **sync = one `item list --show-secrets` per vault** (parallelisable), after which everything is served from memory. Rough full sync for 9 vaults: a few seconds in parallel, done in the background.
- JSON fields without secrets: `id, share_id, vault_id, item_type, title, state, flags, create_time, modify_time`. With secrets: a `content` object (title, note, extra fields, type-specific data).
- Not tested yet: exact login field layout (username, password, URLs, TOTP) and whether a cheap change-detection call exists (needed for incremental sync). `modify_time` per item may be enough to diff after a full fetch.

## AutoFill extension with a free Apple team

Not possible. See [autofill.md](autofill.md) and `spikes/autofill-signing`.

## Still open

- Login content schema and TOTP handling (`pass-cli totp`).
- Cheap incremental sync signal.
- Safari/Chrome behaviour with a third-party provider: moot while the extension is deferred.
- Native backend (Rust core / Swift) feasibility. Not needed for v0.
