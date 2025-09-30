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
}

enum AppTheme: String, CaseIterable {
    case system = "System"
    case light = "Light"
    case dark = "Dark"
}
