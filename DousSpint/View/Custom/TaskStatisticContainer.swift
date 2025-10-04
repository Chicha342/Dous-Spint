//
//  TaskStatisticContainer.swift
//  DousSpint
//
//  Created by Никита on 04.10.2025.
//

import SwiftUI

struct TaskStatisticContainer: View {
    let str: String
    
    @Environment(\.colorScheme) var systemScheme
    
    @EnvironmentObject var settings: ViewModel
    
    var body: some View {
        VStack{
            Text("\(str)")
                .font(.calistoga(size: 32))
                .foregroundColor(customColor())
                .padding()
                
                .background{
                    customImage(for: systemScheme)
                        .frame(width: 358, height: 260)
                        
                }
                .frame(maxWidth: .infinity)
                .frame(height: 77)
                .cornerRadius(8)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(customColorStroke(), lineWidth: 1)
                }
                
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
    
    private func customColorStroke() -> Color {
        switch settings.selectedTheme {
        case .light:
            return Color(r: 246, g: 64, b: 241, alpha: 0.45)
        case .dark:
            return Color(r: 123, g: 29, b: 143)
        case .system:
            return Color(UIColor { trait in
                trait.userInterfaceStyle == .dark
                ? UIColor(red: 123/255, green: 29/255, blue: 143/255, alpha: 1)
                : UIColor(red: 246/255, green: 64/255, blue: 241/255, alpha: 0.45)
            })
        }
    }
    
    private func customImage(for colorScheme: ColorScheme) -> LinearGradient {
        switch settings.selectedTheme {
        case .system:
            return colorScheme == .dark ?
            LinearGradient(colors: [
                Color(r: 77, g: 1, b: 87),
                Color(r: 102, g: 12, b: 62)
            ], startPoint: .top, endPoint: .bottom) :
            LinearGradient(colors: [
                Color(r: 252, g: 230, b: 255),
                Color(r: 255, g: 177, b: 220)
            ], startPoint: .top, endPoint: .bottom)
        case .light:
            return LinearGradient(colors: [
                Color(r: 252, g: 230, b: 255),
                Color(r: 255, g: 177, b: 220)
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
    TaskStatisticContainer(str: "52")
        .environmentObject(ViewModel())
}
