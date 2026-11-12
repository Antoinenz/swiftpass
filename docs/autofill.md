# Autofill

"Autofill" here means **macOS system AutoFill**, not a browser extension.

## Tiers

1. **System AutoFill extension** (main path). An `ASCredentialProviderViewController` extension serves Safari and native apps. Identities are pushed to `ASCredentialIdentityStore` after every sync so suggestions appear instantly, with a biometric prompt only when a secret is released.
2. **Hotkey fill** (fallback, covers Chrome). A global shortcut opens a compact picker pre-filtered to the frontmost site/app. Return types username, Tab, password via `CGEvent` (or paste with pasteboard restore). Needs Accessibility permission.
3. Passkeys (`ASPasskeyCredentialRequest`) later, if Proton data allows.

Chrome: reports suggest Chrome on macOS only uses credential providers for identities in `ASCredentialIdentityStore` and macOS has no "Passwords…" context menu entry for third-party providers. **Unverified**: test on real hardware in Phase 0. Hotkey fill is the guaranteed path for Chrome.

## Speed budget

Credentials ready ≤150 ms warm, ≤400 ms right after unlock.

## Signing constraint: no paid developer account

Direct distribution without a paid Apple Developer account means no Developer ID signing and no notarization. Consequences to verify in Phase 0:

- Users must bypass Gatekeeper (right-click Open, or `xattr -d com.apple.quarantine`). Document this in the install guide.
- The AutoFill credential-provider entitlement may require a provisioning profile that a free personal team cannot obtain, or that expires (free profiles are short-lived). If so, options are: (a) users build from source with their own Apple ID, (b) ad-hoc signed release with the limitation documented, (c) get a paid account later. If the extension cannot load, hotkey fill becomes the primary autofill path.
- Spike: build a hello-world AutoFill extension signed with the free team and see whether macOS lists it under System Settings → AutoFill & Passwords.

## Domain matching

Match on eTLD+1 using the Public Suffix List. Never fill on a mismatch without explicit confirmation.
