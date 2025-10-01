//
//  SplashView.swift
//  DousSpint
//
//  Created by Никита on 30.09.2025.
//

import SwiftUI

struct SplashView: View {
    
    @EnvironmentObject var settings: ViewModel
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(settings.backgroundColor)
                .ignoresSafeArea()
            VStack{
                Image("logoWheel")
                    .resizable()
                    .frame(width: 86, height: 89)
                
                Image("name2lines")
                    .resizable()
                    .frame(width: 133, height: 91)
                    .padding(.top, 8)
                
                Text("Spin. Get. Do.")
                    .font(.calistoga(size: 17))
                    .foregroundColor(textColor)
                    .padding(.top, 28)
            }
        }
        
        var textColor: Color {
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
                return .init(r: 255, g: 220, b: 40)
            }
        }
        
    }
}

#Preview {
    SplashView()
        .environmentObject(ViewModel())
}

#Preview {
    SplashView()
        .environmentObject(ViewModel())
        .preferredColorScheme(.dark)
}
