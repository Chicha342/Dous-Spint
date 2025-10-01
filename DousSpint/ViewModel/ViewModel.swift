//
//  ViewModel.swift
//  DousSpint
//
//  Created by Никита on 30.09.2025.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var selectedTheme: AppTheme = .system
    
    @Published var isLoading: Bool = false
    @Published var mainError: Bool = false
    
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
    
    func themeBackgroundButton(for systemScheme: ColorScheme) -> LinearGradient {
            switch selectedTheme {
            case .light:
                return LinearGradient(
                    colors: [Color(r: 235, g: 176, b: 255),
                             Color(r: 210, g: 150, b: 240)],
                    startPoint: .top, endPoint: .bottom
                )
            case .dark:
                return LinearGradient(
                    colors: [Color(r: 92, g: 24, b: 115),
                             Color(r: 48, g: 12, b: 109)],
                    startPoint: .top, endPoint: .bottom
                )
            case .system:
                return systemScheme == .dark
                ? LinearGradient(
                    colors: [Color(r: 92, g: 24, b: 115),
                             Color(r: 48, g: 12, b: 109)],
                    startPoint: .top, endPoint: .bottom
                )
                : LinearGradient(
                    colors: [Color(r: 235, g: 176, b: 255),
                             Color(r: 210, g: 150, b: 240)],
                    startPoint: .top, endPoint: .bottom
                )
            }
        }
    
    var buttonTextColor: Color {
        switch self.selectedTheme {
        case .light:
            return .init(r: 234, g: 180, b: 248)
        case .dark:
            return .init(r: 33, g: 0, b: 42)
        case .system:
            return Color(UIColor { trait in
                trait.userInterfaceStyle == .dark ?
                UIColor(Color(r: 234, g: 180, b: 248)) : UIColor(Color(r: 33, g: 0, b: 42))
            })
        }
    }
    
    var mainTextColor: Color {
        switch self.selectedTheme {
        case .system:
            return Color(UIColor { traitCollection in
                return traitCollection.userInterfaceStyle == .dark ?
                       UIColor(red: 255/255, green: 220/255, blue: 44/255, alpha: 1) :
                       UIColor(red: 255/255, green: 123/255, blue: 0/255, alpha: 1)
            })
        case .light:
            return .init(r: 255, g: 123, b: 0)
        case .dark:
            return .init(r: 255, g: 220, b: 44)
        }
    }
    
    var loadingTextColor: Color {
        switch self.selectedTheme {
        case .system:
            return Color(UIColor { traitCollection in
                return traitCollection.userInterfaceStyle == .dark ?
                       UIColor(red: 234/255, green: 180/255, blue: 248/255, alpha: 1) :
                    .white
            })
        case .light:
            return .white
        case .dark:
            return .init(r: 234, g: 180, b: 248)
        }
    }
    
    var errorTextColor: Color {
        switch self.selectedTheme {
        case .system:
            return Color(UIColor { traitCollection in
                return traitCollection.userInterfaceStyle == .dark ?
                       UIColor(red: 234/255, green: 180/255, blue: 248/255, alpha: 1) :
                    .black
            })
        case .light:
            return .black
        case .dark:
            return .init(r: 234, g: 180, b: 248)
        }
    }
    
    func errorBgColor(for systemScheme: ColorScheme) -> LinearGradient {
        switch self.selectedTheme {
        case .system:
            return systemScheme == .dark
            ? LinearGradient(colors: [
                Color(r: 169, g: 57, b: 218),
                    Color(r: 78, g: 0, b: 113)],
                startPoint: .top, endPoint: .bottom)
            : LinearGradient(colors: [
                Color(r: 235, g: 235, b: 235),
                    Color(r: 206, g: 206, b: 206)],
                startPoint: .top, endPoint: .bottom)
        case .light:
            return LinearGradient(colors: [
                Color(r: 235, g: 235, b: 235),
                    Color(r: 206, g: 206, b: 206)],
                startPoint: .top, endPoint: .bottom)
        case .dark:
            return LinearGradient(colors: [
                Color(r: 169, g: 57, b: 218),
                    Color(r: 78, g: 0, b: 113)],
                startPoint: .top, endPoint: .bottom)
        }
    }
}

enum AppTheme: String, CaseIterable {
    case system = "System"
    case light = "Light"
    case dark = "Dark"
}
