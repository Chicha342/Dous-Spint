import SwiftUI

struct CoreViewDs: View {
    @State private var isLoading = true

    var body: some View {
        Group {
            if isLoading {
                LoadingViewDS()
            } else {
                ContentView()
            }
        }
    }
}

#Preview {
    CoreViewDs()
}
