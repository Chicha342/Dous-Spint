//
//  HistoryView.swift
//  DousSpint
//
//  Created by Никита on 30.09.2025.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var settings: SettingsViewModel
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(settings.backgroundColor)
                .ignoresSafeArea(edges: .all)
            Text("HistoryView")
        }
    }
}

#Preview {
    HistoryView()
        .environmentObject(SettingsViewModel())
        .colorScheme(.light)
}

#Preview {
    HistoryView()
        .environmentObject(SettingsViewModel())
        .colorScheme(.dark)
}
