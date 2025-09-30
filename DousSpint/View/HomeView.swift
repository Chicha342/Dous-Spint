//
//  HomeView.swift
//  DousSpint
//
//  Created by Никита on 30.09.2025.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var settings: SettingsViewModel
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(settings.backgroundColor)
                .ignoresSafeArea(edges: .all)
            Text("HomeView")
        }
        
    }
}

#Preview {
    HomeView()
        .environmentObject(SettingsViewModel())
}

#Preview {
    HomeView()
        .environmentObject(SettingsViewModel())
        .colorScheme(.dark)
}
