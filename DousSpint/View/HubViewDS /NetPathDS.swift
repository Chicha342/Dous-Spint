import Foundation
import Combine
import Network

final class NetPathDS: ObservableObject {
    @Published private(set) var connected = true
    
    private let pathMonitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Reachability")
    
    init() {
        pathMonitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.connected = (path.status == .satisfied)
            }
        }
        pathMonitor.start(queue: queue)
    }
    
    deinit {
        pathMonitor.cancel()
    }
}
