# Autofill

"Autofill" here means **macOS system AutoFill**, not a browser extension.

## Tiers

1. **System AutoFill extension** (main path). An `ASCredentialProviderViewController` extension serves Safari and native apps. Identities are pushed to `ASCredentialIdentityStore` after every sync so suggestions appear instantly, with a biometric prompt only when a secret is released.
2. **Hotkey fill** (fallback, covers Chrome). A global shortcut opens a compact picker pre-filtered to the frontmost site/app. Return types username, Tab, password via `CGEvent` (or paste with pasteboard restore). Needs Accessibility permission.
3. Passkeys (`ASPasskeyCredentialRequest`) later, if Proton data allows.

Chrome: reports suggest Chrome on macOS only uses credential providers for identities in `ASCredentialIdentityStore` and macOS has no "Passwords…" context menu entry for third-party providers. **Unverified**: test on real hardware in Phase 0. Hotkey fill is the guaranteed path for Chrome.

## Speed budget

Credentials ready ≤150 ms warm, ≤400 ms right after unlock.

## Signing constraint: no paid developer account (spike result)

Tested 2026-11-12 on macOS 27.0.1 / Xcode 27.2 (see `spikes/autofill-signing`):

- With a **free personal team**, Xcode refuses to issue a profile for the `autofill-credential-provider` entitlement ("team does not have a program membership that is eligible").
- **Ad-hoc signing** with that entitlement gets the extension registered, but AMFI kills it on launch (SIGKILL). The entitlement is restricted and needs a provisioning profile.
- The competing app Quick Access for Pass embeds a provisioning profile in its extension and is Developer ID signed.

**Conclusion: the system AutoFill extension needs the paid Apple Developer Program (US$99/yr).** Not possible on the free tier, for users building from source either.

Options:
1. **Pay for the program** and ship the extension, Developer ID signed and notarized (also removes the Gatekeeper workaround).
2. **Free-tier release**: hotkey fill (and the menu bar panel) only, no system AutoFill. Gatekeeper must be bypassed manually. Add the extension later if an account is acquired.

The code is structured so the extension is an add-on over the same core, so option 2 loses nothing already built.

## Domain matching

Match on eTLD+1 using the Public Suffix List. Never fill on a mismatch without explicit confirmation.
