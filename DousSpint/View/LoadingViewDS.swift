//
//  LoadingViewDS.swift
//  DousSpint
//
//  Created by Никита on 17.10.2025.
//

import SwiftUI

struct LoadingViewDS: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        Rectangle()
            .fill(viewModel.backgroundColor)
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    LoadingViewDS()
        .environmentObject(ViewModel())
}
