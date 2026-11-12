# Security

- Hardened Runtime; App Sandbox where possible (App Group shared with the extension).
- Secrets only in Keychain or memory; zero buffers on lock; never log secrets.
- Clipboard writes use the concealed/transient type and auto-clear after 30 s if unchanged.
- Panel excluded from screen capture (`sharingType = .none`) while a password is revealed.
- XPC between app and extension verifies the peer's code signature / audit token.
- Reuse Proton's open-source crypto libraries rather than hand-rolling; test against real vault fixtures.
- Write a threat model and get an outside review of the crypto before any public release.
- Read-only v1 reduces attack surface.
- Unsigned/ad-hoc distribution (see [autofill.md](autofill.md)) weakens users' ability to verify builds: publish checksums and reproducible build steps.
