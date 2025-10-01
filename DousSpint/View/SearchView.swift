//
//  SearchView.swift
//  DousSpint
//
//  Created by Никита on 30.09.2025.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var settings: ViewModel
    
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
        .environmentObject(ViewModel())
        .colorScheme(.light)
}

#Preview {
    SearchView()
        .environmentObject(ViewModel())
        .colorScheme(.dark)
}
