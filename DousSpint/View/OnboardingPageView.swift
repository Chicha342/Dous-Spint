//
//  OnboardingPageView.swift
//  DousSpint
//
//  Created by Никита on 30.09.2025.
//

import SwiftUI

struct OnboardingPageView: View {
    let page: OnboardingPage
    @EnvironmentObject var settings: SettingsViewModel
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(backgroundColor)
                .ignoresSafeArea()
            
            ZStack{
                Image("SunBrustDark")
                
                VStack(spacing: 66){
                    Text(page.title)
                        .font(.calistogaTitle)
                        .foregroundColor(textColor)
                    
                    
                    
                    Image(page.imageName)
                        .resizable()
                        .frame(width: 191, height: 191)
                    
                    
                    Text(page.description)
                        .font(.calistogaBody)
                        .foregroundColor(textColor)
                }
                
            }
        }
    }
    
    private var textColor: Color {
        switch settings.selectedTheme {
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
    
    var backgroundColor: Color {
        switch settings.selectedTheme {
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

#Preview {
    OnboardingPageView(page: OnboardingPage(title: "Spin The Wheel",
                                            description: "Discover inspiring daily challenges.",
                                            imageName: "Wheel",
                                            color: Color.init(r: 49, g: 7, b: 59))).environmentObject(SettingsViewModel())
    
}

#Preview {
    OnboardingPageView(page: OnboardingPage(title: "Spin The Wheel",
                                            description: "Discover inspiring daily challenges.",
                                            imageName: "Wheel",
                                            color: Color.init(r: 49, g: 7, b: 59))).environmentObject(SettingsViewModel())
        .preferredColorScheme(.dark)
    
}
