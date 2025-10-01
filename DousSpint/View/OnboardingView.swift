//
//  OnboardingView.swift
//  DousSpint
//
//  Created by Никита on 30.09.2025.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var isOnboardingActive: Bool
    @State private var currentPage: Int = 0
    @EnvironmentObject var settings: ViewModel
    
    private var textColor: Color {
        switch settings.selectedTheme {
        case .system:
            return Color(UIColor { traitCollection in
                return traitCollection.userInterfaceStyle == .dark ?
                UIColor(red: 243/255, green: 0/255, blue: 237/255, alpha: 1) :
                UIColor(red: 243/255, green: 0/255, blue: 237/255, alpha: 1)
            })
        case .light:
            return .init(r: 243, g: 0, b: 237)
        case .dark:
            return .init(r: 243, g: 0, b: 237)
        }
    }
    
    private var skipColor: Color {
        switch settings.selectedTheme {
        case .system:
            return Color(UIColor { traitCollection in
                return traitCollection.userInterfaceStyle == .dark ?
                UIColor(red: 255/255, green: 235/255, blue: 192/255, alpha: 1):
                UIColor(red: 255/255, green: 123/255, blue: 0/255, alpha: 1)
            })
        case .light:
            return .init(r: 243, g: 0, b: 237)
        case .dark:
            return .init(r: 255, g: 123, b: 0)
        }
    }
    
    private var pages: [OnboardingPage] {
        [
            OnboardingPage(
                title: "Spin the Wheel",
                description: "Discover inspiring daily challenges.",
                imageName: "Wheel",
                color: settings.backgroundColor
            ),
            OnboardingPage(
                title: "Simple & Meaningful",
                description: "Small actions, big impact on your life.",
                imageName: "taskCard",
                color: settings.backgroundColor
            ),
            OnboardingPage(
                title: "Track & Grow",
                description: "Build streaks, celebrate progress.",
                imageName: "Graph",
                color: settings.backgroundColor
            )
        ]
    }
    
    var body: some View {
        ZStack {
            pages[currentPage].color
                .ignoresSafeArea()
            
            VStack(spacing: 0){
                HStack{
                    Spacer()
                    Button("Skip"){
                        completeOnboarding()
                    }
                    .font(.calistoga(size: 24))
                    .padding(.trailing)
                    .foregroundColor(skipColor)
                }
                .padding(.horizontal, 24)
                .padding(.top)
                Spacer()
                
                TabView(selection: $currentPage) {
                    ForEach(0..<pages.count) { index in
                        OnboardingPageView(page: pages[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                MainCustomButton(title: "Next", action: handleButtonAction)
                    .padding(.horizontal, 28)
                    .padding(.bottom, 28)
                
                VStack(spacing: 20) {
                    HStack(spacing: 6) {
                        ForEach(0..<pages.count, id: \.self) { index in
                            Rectangle()
                                .fill(currentPage == index ? textColor : textColor.opacity(0.25))
                                .frame(width: 39, height: 4)
                                .cornerRadius(8)
                        }
                    }
                    
                }
                .padding(.bottom, 24)
            }
        }
    }
    
    // MARK: - Methods
    private func handleButtonAction() {
        if currentPage < pages.count - 1 {
            withAnimation(.easeInOut(duration: 0.3)) {
                currentPage += 1
            }
        } else {
            completeOnboarding()
        }
    }
    
    private func completeOnboarding() {
        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
        
        withAnimation(.easeInOut(duration: 0.5)) {
            isOnboardingActive = false
        }
    }
}

#Preview {
    OnboardingView(isOnboardingActive: .constant(true))
        .environmentObject(ViewModel())
}

#Preview {
    OnboardingView(isOnboardingActive: .constant(true))
        .environmentObject(ViewModel())
        .preferredColorScheme(.dark)
}
