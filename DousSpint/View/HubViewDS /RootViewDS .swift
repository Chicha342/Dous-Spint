import SwiftUI
import OneSignalFramework

struct RootViewDS: View {
    @EnvironmentObject private var containerVM: ContainerViewModelDS

    var body: some View {
        Group {
            switch containerVM.contain {
            case .loading:
                LoadingViewDS()
            case .main:
                ContentView()
            case .checked:
                AppShellDS(containerVM: containerVM)
                    .onAppear {
//                        AppDelegate.orientationLock = [.portrait ,.landscapeLeft, .landscapeRight]
                        
                        OneSignal.Notifications.requestPermission({ accepted in
                            print("User accepted notifications: \(accepted)")
                        }, fallbackToSettings: false)
                    }
            }
        }
    }
}

#Preview {
    RootViewDS()
}
