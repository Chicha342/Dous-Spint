//
//  FavoritesView.swift
//  DousSpint
//
//  Created by Никита on 30.09.2025.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var settings: SettingsViewModel
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(settings.backgroundColor)
                .ignoresSafeArea(edges: .all)
            Text("FavoritesView")
        }
    }
}

#Preview {
    FavoritesView()
        .environmentObject(SettingsViewModel())
        .colorScheme(.light)
}

#Preview {
    FavoritesView()
        .environmentObject(SettingsViewModel())
        .colorScheme(.dark)
}
