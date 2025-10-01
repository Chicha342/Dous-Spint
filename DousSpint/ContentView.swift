//
//  ContentView.swift
//  DousSpint
//
//  Created by Никита on 29.09.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var isSplashActive = false
    @State private var showOnboarding = false
    @StateObject private var settings = ViewModel()
    
    var body: some View {
        VStack {
            
            Group{
                if isSplashActive{
                    if showOnboarding{
                        OnboardingView(isOnboardingActive: $showOnboarding)
                    }else{
                        MainView()
                    }
                }else{
                    SplashView()
                }
            }
        }
        .environmentObject(settings)
        .onAppear {
            let hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
            showOnboarding = !hasCompletedOnboarding
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    isSplashActive = true
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
