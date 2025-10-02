//
//  SecondContainer.swift
//  DousSpint
//
//  Created by Никита on 02.10.2025.
//

import SwiftUI

struct TimeContainer: View {
    let timeStr: String
    
    @Environment(\.colorScheme) var systemScheme
    
    @EnvironmentObject var settings: ViewModel
    
    var body: some View {
        VStack{
            Text("\(timeStr)")
                .font(.calistoga(size: 64))
                .foregroundColor(customColor())
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 249)
                .background(customBgColor())
                .cornerRadius(50)
                .padding(.horizontal)
        }
    }
    
    private func customColor() -> Color {
        switch settings.selectedTheme {
        case .light:
            return Color(r: 33, g: 0, b: 42)
        case .dark:
            return Color(r: 234, g: 180, b: 248)
        case .system:
            return Color(UIColor { trait in
                trait.userInterfaceStyle == .dark
                ? UIColor(red: 234/255, green: 180/255, blue: 248/255, alpha: 1)
                : UIColor(red: 33/255, green: 0/255, blue: 42/255, alpha: 1)
            })
        }
    }
    
    private func customBgColor() -> LinearGradient {
        switch settings.selectedTheme {
        case .system:
            return systemScheme == .dark
            ? LinearGradient(colors: [
                Color(r: 77, g: 1, b: 87),
                Color(r: 102, g: 12, b: 62)
            ], startPoint: .top, endPoint: .bottom)
            : LinearGradient(colors: [
                Color(r: 254, g: 245, b: 255),
                Color(r: 255, g: 234, b: 246)
            ], startPoint: .top, endPoint: .bottom)
        case .light:
            return LinearGradient(colors: [
                Color(r: 254, g: 245, b: 255),
                Color(r: 255, g: 234, b: 246)
            ], startPoint: .top, endPoint: .bottom)
        case .dark:
            return LinearGradient(colors: [
                Color(r: 77, g: 1, b: 87),
                Color(r: 102, g: 12, b: 62)
            ], startPoint: .top, endPoint: .bottom)
        }
    }
}

#Preview {
    TimeContainer(timeStr: "2")
        .environmentObject(ViewModel())
}
