import SwiftUI
@preconcurrency import WebKit
import Combine

struct AppShellDS: View {
    @Environment(\.colorScheme) private var colorScheme
    @StateObject private var container = ScreenFlowDS()
    @StateObject private var connectionPath = NetPathDS()
    
    @State private var presentAlert = false
    @State private var alertMessage = ""
    
    let containerVM: ContainerViewModelDS
    
    var body: some View {
        ZStack {
            background
            VStack(spacing: 0) {
                mainPresent
                mainButtons
            }
        }

        .onReceive(container.$leastError) { handleError($0) }
        .onReceive(connectionPath.$connected.debounce(for: .seconds(1), scheduler: RunLoop.main)) { isConnected($0) }
        .alert("Connection issue", isPresented: $presentAlert) {
            retryButtons
        } message: {
            Text(alertMessage)
        }
    }
}

private extension AppShellDS {
    var background: some View {
        Color(colorScheme == .dark ? .black : .white).ignoresSafeArea()
    }
    
    var mainPresent: some View {
        ZStack {
            PageStackDS(
                urlString: containerVM.linkString ?? containerVM.baseLink,
                container: container,
                containerVM: containerVM
            )
            .ignoresSafeArea(edges: .bottom)
            .onAppear {
//                AppDelegate.orientationLock = .all
                container.leastError = nil
                presentAlert = false
            }
            .onDisappear {
//                AppDelegate.orientationLock = .portrait
            }
            
            if container.isLoading {
                ProgressView()
                    .scaleEffect(1.4)
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
    }
    
    var mainButtons: some View {
        HStack {
            button(icon: "chevron.backward") { container.navigationButtons = .back }
                .disabled(!container.isBack)
                .opacity(!container.isBack ? 0.5 : 1)

            Spacer()
            
            button(icon: "house.fill", size: 45) { container.navigationButtons = .home }
            
            Spacer()
            
            button(icon: "chevron.forward") { container.navigationButtons = .forward }
                .disabled(!container.isForward)
                .opacity(!container.isForward ? 0.5 : 1)

        }
        .padding(.top, 10)
        .padding(.horizontal, 45)
    }
    
    func button(icon: String, size: CGFloat = 25, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .foregroundColor(Color(colorScheme == .dark ? .white : .black))
        }
    }
    
    var retryButtons: some View {
        Group {
            Button("Try again") {
                if let view = container.containerView {
                    if !connectionPath.connected {

                    } else if view.url == nil, let request = container.homeRequest {
                        view.load(request)
                    } else {
                        view.reload()
                    }
                }
            }
            Button("OK", role: .cancel) { }
        }
    }
}

private extension AppShellDS {
    func handleError(_ error: URLError?) {
        guard let error else { return }
        guard isRealConnectionError(error) else { return }
        alertMessage = humanReadable(error: error)
        presentAlert = !alertMessage.isEmpty
    }
    
    func isConnected(_ connected: Bool) {
        if !connected {
            alertMessage = "No Internet connection. Please check your network. And try again later."
            presentAlert = true
        } else if container.leastError != nil {
            container.leastError = nil
            if let view = container.containerView {
                if view.url == nil, let request = container.homeRequest {
                    view.load(request)
                } else {
                    view.reload()
                }
            }
        }
    }
    
    func isRealConnectionError(_ e: URLError) -> Bool {
        switch e.code {
        case .notConnectedToInternet, .timedOut, .cannotFindHost, .cannotConnectToHost, .dnsLookupFailed:
            return true
        case .networkConnectionLost:
            print("⚠️")
            return false
        default:
            return false
        }
    }
    
    func humanReadable(error: URLError) -> String {
        switch error.code {
        case .notConnectedToInternet: return "No Internet connection."
        case .timedOut:               return "Request timed out."
        case .cannotFindHost:         return "Cannot find host."
        case .cannotConnectToHost:    return "Cannot connect to host."
        case .dnsLookupFailed:        return "DNS lookup failed."
        default:                      return error.localizedDescription
        }
    }
}

