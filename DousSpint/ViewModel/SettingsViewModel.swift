//
//  ViewModel.swift
//  DousSpint
//
//  Created by Никита on 30.09.2025.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var selectedTheme: AppTheme = .system
    
    var colorScheme: ColorScheme? {
        switch selectedTheme {
        case .light: return .light
        case .dark: return .dark
        case .system: return nil
        }
    }
    
    var backgroundColor: Color {
        switch self.selectedTheme {
        case .light:
            return .white
        case .dark:
            return Color(r: 49, g: 7, b: 59)
        case .system:
            return Color(UIColor { trait in
                trait.userInterfaceStyle == .dark ?
                UIColor(Color(r: 49, g: 7, b: 59)) :
                    .white
            })
        }
    }
}

enum AppTheme: String, CaseIterable {
    case system = "System"
    case light = "Light"
    case dark = "Dark"
}
