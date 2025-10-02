//
//  StatisticsView.swift
//  DousSpint
//
//  Created by Никита on 30.09.2025.
//

import SwiftUI

struct StatisticsView: View {
    @EnvironmentObject var settings: ViewModel
    
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
        .environmentObject(ViewModel())
        .colorScheme(.light)
}

#Preview {
    StatisticsView()
        .environmentObject(ViewModel())
        .colorScheme(.dark)
}
