//
//  RecentSercesContainer.swift
//  DousSpint
//
//  Created by Никита on 04.10.2025.
//

import SwiftUI

struct RecentSercesContainer: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.colorScheme) var systemColorScheme
    let text: String
    
    var body: some View {
        Text(text)
            .foregroundStyle(customColor())
            .frame(maxWidth: .infinity)
            .font(.poppins(.regular, size: 16))
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(sttrokeColor(), lineWidth: 1)
            }
    }
    
    private func customColor() -> Color {
        switch viewModel.selectedTheme {
        case .system:
            systemColorScheme == .dark ?
            Color(r: 234, g: 180, b: 248):
            Color(r: 212, g: 84, b: 255)
        case .light:
            Color(r: 212, g: 84, b: 255)
        case .dark:
            Color(r: 234, g: 180, b: 248)
        }
    }
    
    private func sttrokeColor() -> Color {
        switch viewModel.selectedTheme {
        case .system:
            systemColorScheme == .dark ?
            Color(r: 164, g: 0, b: 219):
            Color(r: 212, g: 84, b: 255)
        case .light:
            Color(r: 212, g: 84, b: 255)
        case .dark:
            Color(r: 164, g: 0, b: 219)
        }
    }
}

#Preview {
    RecentSercesContainer(text: "Hello")
        .environmentObject(ViewModel())
}
