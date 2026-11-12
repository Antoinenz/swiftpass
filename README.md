# SwiftPass

A fast, native macOS client for [Proton Pass](https://proton.me/pass): an instant menu bar vault browser plus quick macOS AutoFill.

> **Status: planning.** No code yet. Not affiliated with or endorsed by Proton AG.

## Goals

- **Menu bar app that opens instantly** and lists all your items in the same layout as the Proton Pass browser extension: search, vault picker, type filters, copy actions, TOTP.
- **Fast autofill** through macOS's own AutoFill (Safari and native apps), plus a global-hotkey fill for everything else (including Chrome).
- **Quiet, reliable sync.** Works from a local cache, retries silently, and never spams error notifications.
- **Read-only** for v1. Open source, direct download, no App Store.

## Why

Existing Proton Pass menu bar tools wrap the `pass-cli` command line tool. Every search or fill spawns a process, which makes autofill take seconds and sync fail noisily. SwiftPass keeps one long-lived process with an in-memory index so the hot path never touches the network or a subprocess.

## Documentation

See [docs/](docs/README.md): [architecture](docs/architecture.md), [UI](docs/ui.md), [autofill](docs/autofill.md), [sync](docs/sync.md), [security](docs/security.md), [performance](docs/performance.md), [roadmap](docs/roadmap.md), [decisions](docs/decisions.md).

## License

MIT. See [LICENSE](LICENSE).
