//
//  HomeView.swift
//  DousSpint
//
//  Created by Никита on 30.09.2025.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var settings: ViewModel
    
    @State private var showTutorial: Bool = false
    @Environment(\.colorScheme) var systemScheme
    
    let categories: [CategoryButton] = [
        CategoryButton(title: "All", action: { print("All tapped") }),
        CategoryButton(title: "Body", action: { print("Body tapped") }),
        CategoryButton(title: "Mind", action: { print("Mind tapped") }),
        CategoryButton(title: "Soul", action: { print("Soul tapped") }),
        CategoryButton(title: "Connect", action: { print("Connect tapped") }),
        CategoryButton(title: "Create", action: { print("Create tapped") })
    ]
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(settings.backgroundColor)
                .ignoresSafeArea(edges: .all)
            VStack{
                //header
                CustomHeader()
                
                ScrollView{
                    Image("Wheel")
                        .resizable()
                        .frame(width: 331, height: 331)
                        .padding(.top, 29)
                        .opacity(showTutorial ? 0.5 : 1)
                        .opacity(settings.isLoading ? 0.5 : 1)
                        .opacity(settings.mainError ? 0.5 : 1)
                    
                    MainCustomButton(title: "Spin", action: {
                        showTutorial = false
                    })
                        .padding(.horizontal, 100)
                        .padding(.top, 12)
                        .opacity(settings.isLoading ? 0.5 : 1)
                        .opacity(settings.mainError ? 0.5 : 1)
                    
                    
                    Text("Spins left: \(2)/3") // Изменить
                        .font(.poppins(.medium, size: 12))
                        .foregroundColor(settings.mainTextColor)
                        .padding(.top, 8)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 6), count: 3), spacing: 6) {
                        ForEach(categories, id: \.title) { item in
                            SecondCustomButton(title: item.title, action: item.action)
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                
            }
            if showTutorial {
                Text("Spin the wheel to get your first task!")
                    .font(.calistoga(size: 20))
                    .foregroundColor(settings.mainTextColor)
                    .padding()
                    .transition(.opacity)
            }
            if settings.isLoading {
                VStack{
                    ProgressView()
                    
                    Text("Loading...")
                        .font(.poppins(.regular, size: 16))
                        .foregroundColor(settings.loadingTextColor)
                }
                .padding(.bottom)
                
            }
            if settings.mainError {
                VStack{
                    HStack(spacing: 8){
                        Image("errorImage")
                            .resizable()
                            .frame(width: 22, height: 18)
                        
                        Text("Something went wrong.")
                            .font(.poppins(.regular, size: 16))
                            .foregroundColor(settings.errorTextColor)
                    }
                }
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 8)
                        .fill(settings.errorBgColor(for: systemScheme))
                        .opacity(0.8)
                }
            }
        }
        .onAppear{
            handleFirstLaunch()
        }
        
    }
    
    private func handleFirstLaunch() {
        let key = "hasShownTutorial"
        let hasShown = UserDefaults.standard.bool(forKey: key)
        
        if !hasShown {
            showTutorial = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                withAnimation {
                    showTutorial = false
                }
                UserDefaults.standard.set(true, forKey: key)
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(ViewModel())
}

#Preview {
    HomeView()
        .environmentObject(ViewModel())
        .colorScheme(.dark)
}
