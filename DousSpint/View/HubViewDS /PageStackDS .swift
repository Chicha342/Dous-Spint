import SwiftUI
import Combine
@preconcurrency import WebKit

struct PageStackDS: UIViewRepresentable {
    let urlString: String
    @ObservedObject var container: ScreenFlowDS
    var containerVM: ContainerViewModelDS
    
    func makeCoordinator() -> Coordinator { Coordinator(self) }
    
    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
        
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        configuration.defaultWebpagePreferences = preferences
        
        let myMain = WKWebView(frame: .zero, configuration: configuration)
        myMain.navigationDelegate = context.coordinator
        myMain.uiDelegate = context.coordinator
        myMain.allowsBackForwardNavigationGestures = true
        
        container.containerView = myMain
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            context.coordinator.homeRequest = request
            container.homeRequest = request
            myMain.load(request)
        } else {
            print("Wrong URL: \(urlString)")
        }
        
        container.$navigationButtons
            .receive(on: RunLoop.main)
            .sink { [weak myMain] action in
                guard let myMain else { return }
                switch action {
                case .back:
                    if myMain.canGoBack { myMain.goBack() }
                case .forward:
                    if myMain.canGoForward { myMain.goForward() }
                case .home:
                    if let request = context.coordinator.homeRequest { myMain.load(request) }
                case .none:
                    break
                }
                self.container.navigationButtons = .none
            }
            .store(in: &context.coordinator.cancellables)
        
        return myMain
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) { }
    
    class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        var parent: PageStackDS
        var cancellables = Set<AnyCancellable>()
        var homeRequest: URLRequest?
        
        private var suppressSpinnerForThisNav = false
        
        init(_ parent: PageStackDS) {
            self.parent = parent
            super.init()
        }
        
        func webView(_ webView: WKWebView,
                     decidePolicyFor navigationAction: WKNavigationAction,
                     decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            suppressSpinnerForThisNav = (navigationAction.navigationType == .backForward)
            decisionHandler(.allow)
        }
        
        private func publishNavState(_ webView: WKWebView) {
            DispatchQueue.main.async {
                self.parent.container.isBack = webView.canGoBack
                self.parent.container.isForward = webView.canGoForward
            }
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            if !suppressSpinnerForThisNav {
                DispatchQueue.main.async {
                    self.parent.container.isLoading = true
                    self.parent.container.leastError = nil
                }
            }
            publishNavState(webView)
        }
        
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            publishNavState(webView)
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.async {
                self.parent.container.isLoading = false
                self.parent.container.leastError = nil
            }
            suppressSpinnerForThisNav = false
            publishNavState(webView)
        }
        
        
        private func handle(error: Error, webView: WKWebView) {
            let nsError = error as NSError
            
            if let urlError = error as? URLError, urlError.code == .cancelled {
                publishNavState(webView); return
            }

            if nsError.domain == "WebKitErrorDomain" && nsError.code == 102 {
                publishNavState(webView); return
            }
            
            DispatchQueue.main.async {
                self.parent.container.isLoading = false
                if let urlError = error as? URLError {
                    self.parent.container.leastError = urlError
                }
            }
            suppressSpinnerForThisNav = false
            publishNavState(webView)
        }
        
        func webView(_ webView: WKWebView,
                     didFail navigation: WKNavigation!,
                     withError error: Error) {
            handle(error: error, webView: webView)
        }
        
        func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
            if webView.url != nil { webView.reload() }
        }
        
        func webView(_ webView: WKWebView,
                     didFailProvisionalNavigation navigation: WKNavigation!,
                     withError error: Error) {
            handle(error: error, webView: webView)
        }
        
        func webView(_ webView: WKWebView,
                     requestMediaCapturePermissionFor origin: WKSecurityOrigin,
                     initiatedByFrame frame: WKFrameInfo,
                     type: WKMediaCaptureType,
                     decisionHandler: @escaping (WKPermissionDecision) -> Void) {
            decisionHandler(.grant)
        }
    }
}
