//
//  SearchView.swift
//  DousSpint
//
//  Created by Никита on 30.09.2025.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var settings: SettingsViewModel
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(settings.backgroundColor)
                .ignoresSafeArea(edges: .all)
            Text("SearchView")
        }
    }
}

#Preview {
    SearchView()
        .environmentObject(SettingsViewModel())
        .colorScheme(.light)
}

#Preview {
    SearchView()
        .environmentObject(SettingsViewModel())
        .colorScheme(.dark)
}
