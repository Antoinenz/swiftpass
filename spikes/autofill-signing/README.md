# Spike: AutoFill extension with a free Apple team

Minimal menu bar app plus `ASCredentialProviderViewController` extension, generated with `xcodegen generate` from `project.yml` (team ID is the author's; change `DEVELOPMENT_TEAM`).

## Results (2026-11-12, macOS 27.0.1, Xcode 27.2)

| Attempt | Result |
|---|---|
| Free personal team, automatic signing, with `com.apple.developer.authentication-services.autofill-credential-provider` | Build fails: "The selected team does not have a program membership that is eligible for this feature" and no provisioning profile is issued |
| Same project with the entitlement removed | Builds and signs; extension registers with `pluginkit` but is not a usable credential provider |
| Ad-hoc signed (`codesign --sign -`) with the entitlement | Registers with `pluginkit`, but launching the extension is killed by AMFI (exit 137, SIGKILL): restricted entitlement without a provisioning profile |
| Reference: Quick Access for Pass (installed on this Mac) | Developer ID signed, extension embeds `embedded.provisionprofile` with the entitlement |

Conclusion: the macOS AutoFill credential provider extension needs a paid Apple Developer Program membership. See `docs/autofill.md`.
