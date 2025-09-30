//
//  StatisticsView.swift
//  DousSpint
//
//  Created by Никита on 30.09.2025.
//

import SwiftUI

struct StatisticsView: View {
    @EnvironmentObject var settings: SettingsViewModel
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(settings.backgroundColor)
                .ignoresSafeArea(edges: .all)
            Text("StatisticsView")
        }
    }
}

#Preview {
    StatisticsView()
        .environmentObject(SettingsViewModel())
        .colorScheme(.light)
}

#Preview {
    StatisticsView()
        .environmentObject(SettingsViewModel())
        .colorScheme(.dark)
}
