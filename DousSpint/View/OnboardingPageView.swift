//
//  OnboardingPageView.swift
//  DousSpint
//
//  Created by Никита on 30.09.2025.
//

import SwiftUI

struct OnboardingPageView: View {
    let page: OnboardingPage
    @EnvironmentObject var settings: ViewModel
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(settings.backgroundColor)
                .ignoresSafeArea()
            
            ZStack{
                Image("SunBrustDark")
                
                VStack(spacing: 66){
                    Text(page.title)
                        .font(.calistogaTitle)
                        .foregroundColor(settings.mainTextColor)
                    
                    
                    
                    Image(page.imageName)
                        .resizable()
                        .frame(width: 191, height: 191)
                    
                    
                    Text(page.description)
                        .font(.calistogaBody)
                        .foregroundColor(settings.mainTextColor)
                }
                
            }
        }
    }
}

#Preview {
    OnboardingPageView(page: OnboardingPage(title: "Spin The Wheel",
                                            description: "Discover inspiring daily challenges.",
                                            imageName: "Wheel",
                                            color: Color.init(r: 49, g: 7, b: 59))).environmentObject(ViewModel())
    
}

#Preview {
    OnboardingPageView(page: OnboardingPage(title: "Spin The Wheel",
                                            description: "Discover inspiring daily challenges.",
                                            imageName: "Wheel",
                                            color: Color.init(r: 49, g: 7, b: 59))).environmentObject(ViewModel())
        .preferredColorScheme(.dark)
    
}
