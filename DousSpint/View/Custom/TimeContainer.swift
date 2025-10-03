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
                .background{
                    customImage(for: systemScheme)
                        .resizable()
                        .frame(width: 358, height: 260)
                        
                }
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
    
    private func customImage(for colorScheme: ColorScheme) -> Image {
        switch settings.selectedTheme {
        case .system:
            return colorScheme == .dark ?
            Image("cardTimeDark") :
            Image("cardTimeLight")
        case .light:
            return Image("cardTimeLight")
        case .dark:
            return Image("cardTimeDark")
        }
    }
}

#Preview {
    TimeContainer(timeStr: "2")
        .environmentObject(ViewModel())
}
