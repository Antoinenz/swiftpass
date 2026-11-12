import AuthenticationServices
import AppKit

final class CredentialProviderViewController: ASCredentialProviderViewController {
    override func loadView() { view = NSView(frame: NSRect(x: 0, y: 0, width: 320, height: 120)) }
    override func prepareCredentialList(for serviceIdentifiers: [ASCredentialServiceIdentifier]) {
        let label = NSTextField(labelWithString: "SwiftPass spike: \(serviceIdentifiers.first?.identifier ?? "?")")
        label.frame = NSRect(x: 16, y: 50, width: 288, height: 20)
        view.addSubview(label)
    }
    override func provideCredentialWithoutUserInteraction(for credentialIdentity: ASPasswordCredentialIdentity) {
        extensionContext.completeRequest(withSelectedCredential: ASPasswordCredential(user: "spike", password: "spike"))
    }
}
