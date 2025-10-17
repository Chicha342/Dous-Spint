import SwiftUI
@preconcurrency import WebKit
import Combine

enum NavigationButtonsMSA {
    case none, home, back, forward
}

class ScreenFlowDS: ObservableObject {
    @Published var navigationButtons: NavigationButtonsMSA = .none
    
    @Published var isLoading = false
    @Published var isBack = false
    @Published var isForward = false
    @Published var leastError: URLError?
    
    weak var containerView: WKWebView?
    var homeRequest: URLRequest?
}

