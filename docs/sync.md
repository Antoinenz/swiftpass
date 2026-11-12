# Sync

- Initial full sync with progress in the panel footer; afterwards **incremental** (Proton events/revisions if available, else per-vault revision polling), roughly every 60 s and on wake, network change and app activation.
- Apply changes in one SQLite transaction, then diff the search index and the `ASCredentialIdentityStore`.
- Always usable from cache. The footer shows "last synced N min ago"; sync never blocks the UI.

## Failure handling

| Failure | Behaviour |
|---|---|
| Offline, rate limited, 5xx | Silent retry with exponential backoff and jitter |
| Session expired | Try refresh token silently |
| Refresh failed | One de-duplicated "Sign in again" state on the menu bar icon, one notification |
| Anything else | Logged to a ring buffer, surfaced via Settings → Copy diagnostics, not a popup |

No error notification for transient failures, ever.
