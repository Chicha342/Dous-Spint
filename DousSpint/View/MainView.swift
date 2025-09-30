//
//  MainView.swift
//  DousSpint
//
//  Created by Никита on 30.09.2025.
//

import SwiftUI

struct MainView: View {
    @StateObject private var settingsViewModel = SettingsViewModel()
    
    init() {
        setupTapBarAppearance()
    }
    
    private func setupTapBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        appearance.backgroundColor = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ?
            UIColor(red: 49/255, green: 7/255, blue: 59/255, alpha: 1.0) :
            UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        }
        
        let poppinsLight = UIFont(name: "Poppins-Light", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .light)
        
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor { traitCollection in
                traitCollection.userInterfaceStyle == .dark ?
                UIColor(red: 243/255, green: 0/255, blue: 237/255, alpha: 1.0) :
                UIColor(red: 243/255, green: 0/255, blue: 237/255, alpha: 1.0)
            },
            .font: poppinsLight
        ]
        
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor { traitCollection in
                traitCollection.userInterfaceStyle == .dark ?
                UIColor(red: 181/255, green: 132/255, blue: 194/255, alpha: 1.0) :
                UIColor(red: 136/255, green: 136/255, blue: 136/255, alpha: 1.0)
            },
            .font: poppinsLight
        ]
        
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ?
            UIColor(red: 243/255, green: 0/255, blue: 237/255, alpha: 1.0) :
            UIColor(red: 243/255, green: 0/255, blue: 237/255, alpha: 1.0)
        }
        
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ?
            UIColor(red: 181/255, green: 132/255, blue: 194/255, alpha: 1.0) :
            UIColor(red: 136/255, green: 136/255, blue: 136/255, alpha: 1.0)
        }
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    @State private var selectedTab: TabItem = .home
    
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(TabItem.allCases, id: \.self) { tab in
                tab.view
                    .tabItem {
                        Image(selectedTab == tab ? tab.iconSelected : tab.iconDefault)
                            .renderingMode(.template)
                        
                        Text(tab.title)
                    }
                    .tag(tab)
            }
        }
        .accentColor(Color(red: 243/255, green: 0/255, blue: 237/255))
        .preferredColorScheme(settingsViewModel.colorScheme)
        .environmentObject(settingsViewModel)
        
    }
}

#Preview {
    MainView()
        .preferredColorScheme(.light)
}
