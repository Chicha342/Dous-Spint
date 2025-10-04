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
    
    @State private var currentTask: TaskItem? = nil
    @State private var showTaskDetail = false
    @State private var selectedTask: TaskItem? = nil
    
    @State private var selectedCategory: String = "All"
    
    private var categories: [CategoryButton] {
        [
            CategoryButton(title: "All", action: {
                selectedCategory = "All"
            }),
            CategoryButton(title: "Body", action: {
                selectedCategory = "Body"
            }),
            CategoryButton(title: "Mind", action: {
                selectedCategory = "Mind"
            }),
            CategoryButton(title: "Soul", action: {
                selectedCategory = "Soul"
            }),
            CategoryButton(title: "Connect", action: {
                selectedCategory = "Connect"
            }),
            CategoryButton(title: "Create", action: {
                selectedCategory = "Create"
            })
        ]
    }
    
    private var filteredTasks: [TaskItem] {
        if selectedCategory == "All" {
            return settings.myTasks
        } else {
            return settings.myTasks.filter { $0.category == selectedCategory }
        }
    }
    
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
                        .opacity(
                            showTutorial || settings.isLoading || settings.mainError ? 0.5 : 1
                        )
                    
                    MainCustomButton(title: "Spin", action: {
                        guard settings.spinsLeftToday != 0 else {
                            settings.showError()
                            return
                        }
                        
                        showTutorial = false
                        spinWheel()
                    }, height: 56)
                    .padding(.horizontal, 120)
                    .opacity(
                        settings.isLoading || settings.mainError ? 0.5 : 1
                    )
                    
                    
                    Text("Spins left: \(settings.spinsLeftToday)/3")
                        .font(.poppins(.medium, size: 12))
                        .foregroundColor(settings.mainTextColor)
                        .padding(.top, 8)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 6), count: 3), spacing: 6) {
                        ForEach(categories, id: \.title) { item in
                            SecondCustomButton(title: item.title,
                                               action: item.action,
                                               isActive: selectedCategory == item.title)
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    if !filteredTasks.isEmpty {
                        LazyVStack(spacing: 12) {
                            ForEach(filteredTasks) { task in
                                TaskContainer(task: task, secondatyButtonAction: {
                                    selectedTask = task
                                }, primaryButtonAction: {
                                    selectedTask = task
                                })
                                .frame(maxWidth: .infinity)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical)
                    } else {
                        Text("No tasks in '\(selectedCategory)' category")
                            .font(.calistoga(size: 14))
                            .foregroundColor(settings.buttonTextColor.opacity(0.8))
                            .multilineTextAlignment(.center)
                            .padding(.top, 10)
                    }
                    
                    //Vstack end
                }
            }
            
        }
        .animation(.easeInOut(duration: 0.35), value: selectedCategory)
        .fullScreenCover(isPresented: Binding(
            get: { selectedTask != nil },
            set: { if !$0 { selectedTask = nil } }
        )) {
            if let task = selectedTask {
                TaskDetails(task: task)
                    .environmentObject(settings)
            } else {
                Color.clear
            }
        }
        .overlay(content: {
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
                .padding(.bottom, 40)
                
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
        })
        .onAppear{
            handleFirstLaunch()
        }
        .onReceive(NotificationCenter.default.publisher(for: .closeAllSheets)) { _ in
            selectedTask = nil
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
    
    private func spinWheel() {
        guard settings.spinsLeftToday > 0 else { return }
        
        settings.isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if let task = settings.spinWheel() {
                settings.isLoading = false
            } else {
                settings.showError()
                settings.isLoading = false
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
